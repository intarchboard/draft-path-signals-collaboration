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
  RFC8558:
  I-D.irtf-panrg-what-not-to-do:
  I-D.per-app-networking-considerations:
  RFC5218:
  RFC6709:

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

...

# Acknowledgments

The authors would like to thank everyone at the IETF, the IAB, and our day jobs for interesting thoughts and proposals in this space.
