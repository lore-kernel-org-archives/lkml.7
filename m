Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1,WEIRD_QUOTING autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D91C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 08:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1145E20673
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 08:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634132AbfIYIaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 04:30:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36354 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2634101AbfIYIaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 04:30:25 -0400
Received: from [65.39.69.237] (helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iD2gY-0007mG-I2; Wed, 25 Sep 2019 10:30:06 +0200
Date:   Wed, 25 Sep 2019 10:29:49 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dave Hansen <dave.hansen@intel.com>
cc:     Greg KH <gregkh@linuxfoundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, corbet@lwn.net, sashal@kernel.org,
        ben@decadent.org.uk, labbott@redhat.com, andrew.cooper3@citrix.com,
        tsoni@codeaurora.org, keescook@chromium.org, tony.luck@intel.com,
        linux-doc@vger.kernel.org, dan.j.williams@intel.com
Subject: [PATCH] Documentation/process: Clarify disclosure rules
In-Reply-To: <5e9f2343-1a76-125a-9555-ab26f15b4487@intel.com>
Message-ID: <alpine.DEB.2.21.1909251028390.10825@nanos.tec.linutronix.de>
References: <20190910172644.4D2CDF0A@viggo.jf.intel.com> <20190910172649.74639177@viggo.jf.intel.com> <20190911154453.GA14152@kroah.com> <5e9f2343-1a76-125a-9555-ab26f15b4487@intel.com>
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

The role of the contact list provided by the disclosing party and how it
affects the disclosure process and the ability to include experts into
the development process is not really well explained.

Neither is it entirely clear when the disclosing party will be informed
about the fact that a developer who is not covered by an employer NDA needs
to be brought in and disclosed.

Explain the role of the contact list and the information policy along with
an eventual conflict resolution better.

Reported-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 Documentation/process/embargoed-hardware-issues.rst |   40 ++++++++++++++++----
 1 file changed, 33 insertions(+), 7 deletions(-)

--- a/Documentation/process/embargoed-hardware-issues.rst
+++ b/Documentation/process/embargoed-hardware-issues.rst
@@ -143,6 +143,20 @@ via their employer, they cannot enter in
 in their role as Linux kernel developers. They will, however, agree to
 adhere to this documented process and the Memorandum of Understanding.
 
+The disclosing party should provide a list of contacts for all other
+entities who have already been, or should be, informed about the issue.
+This serves several purposes:
+
+ - The list of disclosed entities allows communication accross the
+   industry, e.g. other OS vendors, HW vendors, etc.
+
+ - The disclosed entities can be contacted to name experts who should
+   participate in the mitigation development.
+
+ - If an expert which is required to handle an issue is employed by an
+   listed entity or member of an listed entity, then the response teams can
+   request the disclosure of that expert from that entity. This ensures
+   that the expert is also part of the entity's response team.
 
 Disclosure
 """"""""""
@@ -158,10 +172,7 @@ Mitigation development
 """"""""""""""""""""""
 
 The initial response team sets up an encrypted mailing-list or repurposes
-an existing one if appropriate. The disclosing party should provide a list
-of contacts for all other parties who have already been, or should be,
-informed about the issue. The response team contacts these parties so they
-can name experts who should be subscribed to the mailing-list.
+an existing one if appropriate.
 
 Using a mailing-list is close to the normal Linux development process and
 has been successfully used in developing mitigations for various hardware
@@ -175,9 +186,24 @@ development branch against the mainline
 stable kernel versions as necessary.
 
 The initial response team will identify further experts from the Linux
-kernel developer community as needed and inform the disclosing party about
-their participation. Bringing in experts can happen at any time of the
-development process and often needs to be handled in a timely manner.
+kernel developer community as needed. Bringing in experts can happen at any
+time of the development process and needs to be handled in a timely manner.
+
+If an expert is employed by or member of an entity on the disclosure list
+provided by the disclosing party, then participation will be requested from
+the relevant entity.
+
+If not, then the disclosing party will be informed about the experts
+participation. The experts are covered by the Memorandum of Understanding
+and the disclosing party is requested to acknowledge the participation. In
+case that the disclosing party has a compelling reason to object, then this
+objection has to be raised within five work days and resolved with the
+incident team immediately. If the disclosing party does not react within
+five work days this is taken as silent acknowledgement.
+
+After acknowledgement or resolution of an objection the expert is disclosed
+by the incident team and brought into the development process.
+
 
 Coordinated release
 """""""""""""""""""
