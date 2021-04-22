---
title: Considerations on Application - Network Collaboration Using Path Signals
abbrev: Path Signals Collab
docname: draft-iab-path-signals-collaboration-latest
date:
category: bcp

ipr: trust200902
keyword: Internet-Draft

stand_alone: yes
pi: [sortrefs, symrefs]

author:
  -
    ins: J. Arkko
    name: Jari Arkko
    org: Ericsson
    email: jari.arkko@ericsson.com

  -
    ins: T. Hardie
    name: Ted Hardie
    org: Cisco
    email: ted.ietf@gmail.com

  -
    ins: T. Pauly
    name: Tommy Pauly
    org: Apple
    email: tpauly@apple.com

  -
    ins: M. Kühlewind
    name: Mirja Kühlewind
    org: Ericsson
    email: mirja.kuehlewind@ericsson.com


normative:


informative:
  RFC0793:
  RFC5218: 
  RFC6709:
  RFC7305:
  RFC8558:
  I-D.ietf-quic-transport:
  I-D.irtf-panrg-what-not-to-do:
  I-D.per-app-networking-considerations:
  I-D.arkko-path-signals-information:
  I-D.iab-covid19-workshop:
   title: "Report from the IAB COVID-19 Network Impacts Workshop 2020"
   author:
    - ins: J. Arkko 
    - ins: S. Farrell
    - ins: M. Kühlewind
    - ins: C. Perkins
   date: February 2021
   seriesinfo: "Internet Draft (Work in Progress), draft-iab-covid19-workshop, IETF"
   
--- abstract

Path signals are messages seen by on-path elements examining transport
protocols. Current preference for good protocol design indicates
desire for constructing explict rather than implicit signals to carry
information. For instance, the ability of various middleboxes to read
TCP messaging was an implicit signal that lead to difficulties in
evolving the TCP protocol without breaking connectivity through some
of those middleboxes.

This document discusses how information could be passed in these path
signals, and provides some advice on what collaboration modes might be
beneficial, and which might be less likely to be used by applications
or networks.

--- middle

# Introduction

{{RFC8558}} discusses the topic of path signals: Path signals are
messages seen by on-path elements examining transport protocols.
There's a difference between implicit and explicit signals. For
instance, TCP's well-known messages {{RFC0793}} are in the clear, and
often interpreted in various ways by on-path elements. In contrast,
QUIC protects almost all of this information, and hence end-to-end
signaling becomes opaque for network elements in between. QUIC
does provide some information, but has chosen to make these
signals (such as the Spin bit) explicit {{I-D.ietf-quic-transport}}.

Many attempts have been made at network - application collaboration
using path signals.  Section 2 discusses some of the experiences and
guidelines determine from those attempts. This draft then focuses on
the specific question of what collaboration modes are useful. The
draft attempts to provide guidance in the form of architectural
principles.

# Past Guidance

Incentives are a well understood problem in general but perhaps not
fully internalised for various designs attempting to establish
collaboration between applications and path elements. The
principle is that both receiver and sender of information must acquire
tangible and immediate benefits from the communication, such as
improved performance,

A related issue is understanding whether a business
model or ecosystem change is needed. Some designs may work well without any
monetary or payment or cross-administrative domains agreements. For
instance, I could ask my packets to be prioritised relative to each
other and that shouldn’t affect anything else. Some other designs may
require a matching business ecosystem change to support what is being
proposed, and may be much harder to achieve. For instance, requesting
prioritisation over other people’s traffic may imply that you have to
pay for that which may not be easy even for a single provider let
alone across many.

But on to more technical aspects.

The main guidance in {{RFC8558} is to be aware that implicit signals
will be used whether intended or not. Protocol designers should
consider either hiding these signals when the information should not
be visible, or using explicit signals when it should be.

{{I-D.irtf-panrg-what-not-to-do}} discusses many past failure cases, a
catalogue of past issues to avoid. It also provides relevant
guidelines for new work, from discussion of incentives to more
specific observations, such as the need for outperforming end-to-end
mechanisms (Section 4.4), considering the need for per-connection
state (Section 4.6), and so on.

There are also more general guidance documents, e.g., {{RFC5218}}
discusses protocol successes and failures, and provides general advice
on incremental deployability etc. Internet Technology Adoption and
Transition (ITAT) workshop report {{RFC7305}} is also recommended
reading on this same general topic. And {{RFC6709}} discusses protocol
extensibility, and provides general advice on the importance of global
interoperability and so on.

# Principles

This section attempts to provide some architecture-level principles
that would help future designers, explain past issues and recommend
useful models to apply.

...

A large number of our protocol mechanisms today fall into one of two
categories: authenticated and private communication that is only visible
by the end-to-end nodes; and unauthenticated public communication that
is visible to all nodes on a path. RFC 8558 explores the line between data
that is protected and path signals.

There is a danger in taking a position that is too extreme towards either
exposing all information to the path, or hiding all information from the
path. Exposed information encourages pervasive monitoring, which is
described in RFC 7258. But a lack of all path signaling, on the other hand,
may be harmful to network management and the ability for networks to
provide useful services. There are many cases where elements on the network
path can provide beneficial services, but only if they can coordinate with
the endpoints. This tradeoff between privacy and network functions has in
some cases led to an adversarial stance between privacy and the ability for
the network path to provide intended functions.

One way to resolve this conflict is to add more explicit trust and
coordination between endpoints and network devices. VPNs are a good example
of a case where there is an explicit authentication and negotiation with a
network path element that’s used to optimize behavior or gain access to
specific resources. 

The goal of improving privacy and trust on the Internet does not necessarily
need to remove the ability for network elements to perform beneficial
functions. We should instead improve the way that these functions are
achieved. Our goals should be:
- To ensure that information is distributed intentionally, not accidentally; 
- To understand the privacy and other implications of any distributed  information; and
- To gate the distribution of information on the consent of the relevant parties

These goals for distribution apply equally to senders, receivers, and path
elements.

We can establish some basic questions that any new network path functions
should consider:
- What is the minimum set of entities that need to be involved in order to perform this function?
- What is the minimum information each entity in this set needs to perform its part of the function correctly and reliably?
- Which entities must consent to each piece of information that is shared?

Consent and trust must determine the distribution of information. The set of
entities that need to consent is determined by the scope and specificity of
the information being shared.  

If we look at many of the ways network path functions are achieved today, we
find that many if not most of them fall short the standard set up by the
questions above. Too often, they rely on information being sent without
limiting the scope of distribution or providing any negotiation or consent.

Going forward, new standards work in the IETF needs to focus on addressing
this gap by providing better alternatives and mechanisms for providing path
functions. Note that not all of these functions can be achieved in a way that
preserves a high level of user privacy from the network; in such cases, it is
incumbent upon us to not ignore the use case, but instead to define the high
bar for consent and trust, and thus define a limited applicability for those
functions.

## Parties Need to Consent

...

## Information Specificity

One common problem in finding a workable solution for network -
application collaboration is information leakage. All parties are
afraid of either their own propietary information or the users' data
leaking to others. Oddly enough, no one is usually worried about
users' data leaking to themselves, but we digress. :-) 

{{I-D.per-app-networking-considerations}} discusses how applications
may be identified through collaboration mechanisms. This can be
harmful, as in extreme cases it may lead to undesirable prioritization
decisions or even blocking certain
applications. {{I-D.per-app-networking-considerations}} explains how
to reduce the latter problem by categories or requested service rather
than specific application identity, such as providing the category
"video call service" rather than the name of a particular application
performing conference call or video call services. This points to a
more general principle of information specificity, providing only the
information that is needed for the other party to perform the
collaboration task that is desired by this party, and not more. This
applies to information sent by an application about itself,
information sent about users, or information sent by the network.

An architecture can follow the guideline from RFC 8558 in using
explicit signals, but still fail to differentiate properly between
information that should be kept private and information that should be
shared.

In looking at what information can or cannot easily be passed, we
can look at both information from the network to the application,
and from the application to the network.

For the application to the network direction, user-identifying
information can be problematic for privacy and tracking reasons.
Similarly, application identity can be problematic, if it might form
the basis for prioritization or discrimination that the that
application provider may not wish to happen. It may also have
undesirable economic consequences, such as extra charges for the
consumer from a priority service where a regular service would have
worked.

On the other hand, as noted above, information about general classes
of applications may be desirable to be given by application providers,
if it enables prioritization that would improve service, e.g.,
differentiation between interactive and non-interactive services.

For the network to application direction there's less directly
sensitive information. Various network conditions, predictive
bandwidth and latency capabilities, and so on might be attractive
information that applications can use to determine, for instance,
optimal strategies for changing codecs.

However, care needs to be take to ensure that neither private
information about the individual user (such as user's physical
location) is not indirectly exposed through this
information. Similarly, this information should not form a mechanism
to provide a side-channel into what other users are doing.

## Authenticating Discussion Partners 

(even outside the client and server)

...

## Authentication does not equal Trust

...

## Granularity

In the IAB Covid-19 Network Impacts workshop Jana Iyengar brought up
the granularity of operations {{I-D.iab-covid19-workshop}}.  There are
many reasons why per-flow designs are problematic: scalability, need
to release information about individual user’s individual activities,
etc. Perhaps designs that work on aggregates would work better.

# Acknowledgments

The authors would like to thank everyone at the IETF, the IAB, and our
day jobs for interesting thoughts and proposals in this space.
Fragments of this document were also in
{{I-D.arkko-path-signals-information}} that was published earlier.
