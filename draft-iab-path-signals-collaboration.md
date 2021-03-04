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
  RFC5218: 
  RFC6709: 
  RFC8558:
  I-D.irtf-panrg-what-not-to-do:
  I-D.per-app-networking-considerations:
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

...

--- middle

# Introduction

...

# Past Guidance

...

{{RFC8558}} discusses the topic of path signals. The main guidance is
to be aware that implicit signals will be used whether intended or
not. Protocol designers should consider either hiding these signals
when the information should not be visible, or using explicit signals
when it should be.

{{I-D.irtf-panrg-what-not-to-do}} discusses many past failure cases, a
catalogue of past issues to avoid.

{{I-D.per-app-networking-considerations}} discusses common use cases
for networks that have tailored behaviour for specific applications,
and some associated privacy/network neutrality problems with this.

There are also more general guidance documents, e.g., {{RFC5218}}
discusses protocol successes and failures, and provides general advice
on incremental deployability etc. And {{RFC6709}} discusses protocol
extensibility, and provides general advice on the importance of global
interoperability and so on.

# Principles

This section attempts to provide some architecture-level principles
that would help future designers, explain past issues and recommend
useful models to apply.

...

## Parties Need to Consent

...

## Information Specificity

One common problem in finding a workable solution for network -
application collaboration is information leakage. All parties are
afraid of either their own propietary information or the users' data
leaking to others. (Oddly enough, no one is usually worried about
users' data leaking to themselves, but I digress. :-) )

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

## Incentives and Business Models

Incentives are a well understood problem in general but perhaps
not fully internalised for APN or QoS-like designs; a principle might
be that both receiver and sender of information must acquire tangible
and immediate benefits from the communication, such as improved
performance,

A related issue is understanding whether there is or is not a business
model or ecosystem change. Some designs may work well without any
monetary or payment or cross-administrative domains agreements. For
instance, I could ask my packets to be prioritised relative to each
other and that shouldn’t affect anything else. Some other designs may
require a matching business ecosystem change to support what is being
proposed, and may be much harder to achieve. For instance, requesting
prioritisation over other people’s traffic may imply that you have to
pay for that which may not be easy even for a single provider let
alone across many.

# Acknowledgments

The authors would like to thank everyone at the IETF, the IAB, and our day jobs for interesting thoughts and proposals in this space.
