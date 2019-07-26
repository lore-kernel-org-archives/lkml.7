Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,
	WEIRD_QUOTING autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A240C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E8FD21852
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387546AbfGZOrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 10:47:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49411 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfGZOrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 10:47:43 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hr1VR-0004rv-A8; Fri, 26 Jul 2019 16:47:37 +0200
Date:   Fri, 26 Jul 2019 16:47:35 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jonathan Corbet <corbet@lwn.net>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, security@kernel.org,
        linux-doc@vger.kernel.org, Jiri Kosina <jkosina@suse.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH] Documentation/admin-guide: Embargoed hardware security
 issues
In-Reply-To: <20190725151302.16a3e0e3@lwn.net>
Message-ID: <alpine.DEB.2.21.1907261522050.1791@nanos.tec.linutronix.de>
References: <20190725130113.GA12932@kroah.com> <20190725151302.16a3e0e3@lwn.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jul 2019, Jonathan Corbet wrote:
> > Note, this document has gone through numerous reviews by a number of
> > kernel developers, developers at some of the Linux distros, as well as
> > all of the lawyers from almost all open source-related companies.  It's
> > been sitting on my local drive with no comments for a few months now,
> > and it's about time to get this out and merged properly.
> > 
> > If anyone has any final comments, please let me know.
> 
> I do think it could benefit from a pass for basic language issues; I can do
> that if such an effort would be welcome.

Definitely!

> > +
> > +The list is encrypted and email to the list can be sent by either PGP or
> > +S/MIME encrypted and must be signed with the reporter's PGP key or S/MIME
> > +certificate. The list's PGP key and S/MIME certificate are available from
> > +https://www.kernel.org/....
> 
> Somebody needs to fill in some dots there...:)

Yes. I need to sort that out with Konstantin before the thing gets merged,
but we wanted to give it a wider audience in general.
 
> > +The hardware security team identifies the developers (domain experts) which
> > +form the initial response team for a particular issue. The initial response
> 
> s/which form/who will form/
> 
> > +team can bring in further developers (domain experts) to address the issue
> > +in the best technical way.
> 
> Does the reporter get any say in who can be in this group?  That should
> probably be made explicit either way.

See below.

> > +The hardware security team will provide the disclosing party a list of
> > +developers (domain experts) who should be informed initially about the
> > +issue after confirming with the developers  that they will adhere to this
> > +Memorandum of Understanding and the documented process. These developers
> > +form the initial response team and will be responsible for handling the
> > +issue after initial contact. The hardware security team is supporting the
> > +response team, but is not necessarily involved in the mitigation
> > +development process.
> 
> Again, "should be informed" is conditional, suggesting that the reporter
> might have some sort of veto power.  But the actual policy is not clear.

Yes and no. That's a tricky field. We surely need some agreement with the
reporter/owner, but of course we want as much freedom here as we can
get. The past issues were always a pain when we had the need to get a
particular expert into the group.

> > +While individual developers might be covered by a non-disclosure agreement
> > +via their employer, they cannot enter individual non-disclosure agreements
> > +in their role as Linux kernel developers. They will, however, adhere to
> > +this documented process and the Memorandum of Understanding.
> 
> They will *agree to* adhere ...  We expect that actual adherence will be
> the case but there is no way (even if an NDA were involved) to guarantee
> that.

Correct.
 
> > +Disclosure
> > +""""""""""
> > +
> > +The disclosing party provides detailed information to the initial response
> > +team via the specific encrypted mailing-list.
> > +
> > +From our experience the technical documentation of these issues is usually
> > +a sufficient starting point and further technical clarification is best
> > +done via email.
> > +
> > +Mitigation development
> > +""""""""""""""""""""""
> > +
> > +The initial response team sets up an encrypted mailing-list or repurposes
> > +an existing one if appropriate. The disclosing party should provide a list
> > +of contacts for all other parties who have already been, or should be
> > +informed about the issue. The response team contacts these parties so they
> > +can name experts who should be subscribed to the mailing-list.
> > +
> > +Using a mailing-list is close to the normal Linux development process and
> > +has been successfully used in developing mitigations for various hardware
> > +security issues in the past.
> > +
> > +The mailing-list operates in the same way as normal Linux development.
> > +Patches are posted, discussed and reviewed and if agreed on applied to a
> > +non-public git repository which is only accessible to the participating
> > +developers via a secure connection. The repository contains the main
> > +development branch against the mainline kernel and backport branches for
> > +stable kernel versions as necessary.
> 
> Do we want to envision a KPTI-like situation where the mitigation can be
> developed publicly?  Or perhaps just handle any such case if and when it
> ever arises?

Yes, we handle that when it happens which is hopefully never.

> > +Process ambassadors
> > +-------------------
> > +
> > +For assistance with this process we have established ambassadors in various
> > +organizations, who can answer questions about or provide guidance on the
> > +reporting process and further handling. Ambassadors are not involved in the
> > +disclosure of a particular issue, unless requested by a response team or by
> > +an involved disclosed party. The current ambassadors list:
> > +
> > +  ============== ========================================================
> > +  ARM
> > +  AMD
> > +  IBM
> > +  Intel
> > +  Qualcomm
> > +
> > +  Microsoft
> > +  VMware
> > +  XEN
> > +
> > +  Canonical
> > +  Debian
> > +  Oracle
> > +  Redhat
> > +  Suse           Jiri Kosina <jkosina@suse.com>
> > +
> > +  Amazon
> > +  Google
> > +  ============== ========================================================
> 
> Having companies without names seems a little weird.  Unless perhaps you
> have people teed up to add their names in follow-on patches?

We already talked to companies and the names should come forth before this
is finished.
 
> > +Encrypted mailing-lists
> > +-----------------------
> > +
> > +We use encrypted mailing-lists for communication. The operating principle
> > +of these lists is that email sent to the list is encrypted either with the
> > +list's PGP key or with the list's S/MIME certificate. The mailing-list
> > +software decrypts the email and re-encrypts it individually for each
> > +subscriber with the subscriber's PGP key or S/MIME certificate. Details
> > +about the mailing-list software and the setup which is used to ensure the
> > +security of the lists and protection of the data can be found here:
> > +https://www.kernel.org/....
> 
> That URL is also in need of completion.
> 
> The topic of encrypted mailing lists is visited several times in this
> document; I wonder if that could be coalesced somehow?

Suggestions welcome.

> > +Each subscriber needs to send a subscription request to the response team
> > +by email. The email must be signed with the subscriber's PGP key or S/MIME
> > +certificate. If a PGP key is used, it must be available from a public key
> > +server and is ideally connected to the Linux kernel's PGP web of trust. See
> > +also: https://www.kernel.org/signature.html.
> 
> The "public key server" thing isn't working quite as well as it was; does
> this requirement need to be revisited?

I think so. That was written way before that mess happened.
 
Thanks,

	tglx
