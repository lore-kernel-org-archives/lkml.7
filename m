Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D37C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 14:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FEC820717
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 14:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730304AbfIMOWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 10:22:07 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:53298 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727405AbfIMOWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 10:22:07 -0400
Received: (qmail 1755 invoked by uid 2102); 13 Sep 2019 10:22:05 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 13 Sep 2019 10:22:05 -0400
Date:   Fri, 13 Sep 2019 10:22:05 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Joe Perches <joe@perches.com>
cc:     Andy Whitcroft <apw@canonical.com>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] checkpatch.pl: Don't complain about nominal authors if
 there isn't one
In-Reply-To: <e4f60b3f68bd214261b946f34ea0459098da00c3.camel@perches.com>
Message-ID: <Pine.LNX.4.44L0.1909131014410.1466-200000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1559625215-505712803-1568384525=:1466"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1559625215-505712803-1568384525=:1466
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Thu, 12 Sep 2019, Joe Perches wrote:

> On Thu, 2019-09-12 at 16:55 -0400, Alan Stern wrote:
> > checkpatch.pl shouldn't warn about a "Missing Signed-off-by: line by
> > nominal patch author" if there is no nominal patch author.  Without
> > this change, checkpatch always gives me the following warning:
> > 
> >         WARNING: Missing Signed-off-by: line by nominal patch author ''
> 
> When/how does this occur?  Example please.

The patch itself is a good example.  Attached to this email is the
patch file in the form I keep it (from quilt, not git; note that quilt
doesn't do a good job of handling the "---" line so I leave it out and
insert it when submitting the patch).  Try saving the attachment and
running it through checkpatch.pl.  Here's what I get:


$ scripts/checkpatch.pl /tmp/checkpatch-author-fix.patch 
WARNING: Missing Signed-off-by: line by nominal patch author ''

total: 0 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/tmp/checkpatch-author-fix.patch has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


Would you like me to resubmit the patch with this example added to the
patch description?

Alan Stern

---1559625215-505712803-1568384525=:1466
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="checkpatch-author-fix.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44L0.1909131022050.1466@iolanthe.rowland.org>
Content-Description: 
Content-Disposition: attachment; filename="checkpatch-author-fix.patch"

Y2hlY2twYXRjaC5wbCBzaG91bGRuJ3Qgd2FybiBhYm91dCBhICJNaXNzaW5n
IFNpZ25lZC1vZmYtYnk6IGxpbmUgYnkNCm5vbWluYWwgcGF0Y2ggYXV0aG9y
IiBpZiB0aGVyZSBpcyBubyBub21pbmFsIHBhdGNoIGF1dGhvci4gIFdpdGhv
dXQNCnRoaXMgY2hhbmdlLCBjaGVja3BhdGNoIGFsd2F5cyBnaXZlcyBtZSB0
aGUgZm9sbG93aW5nIHdhcm5pbmc6DQoNCglXQVJOSU5HOiBNaXNzaW5nIFNp
Z25lZC1vZmYtYnk6IGxpbmUgYnkgbm9taW5hbCBwYXRjaCBhdXRob3IgJycN
Cg0KU2lnbmVkLW9mZi1ieTogQWxhbiBTdGVybiA8c3Rlcm5Acm93bGFuZC5o
YXJ2YXJkLmVkdT4NCg0KDQoNCiBzY3JpcHRzL2NoZWNrcGF0Y2gucGwgfCAg
ICAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pDQoNCkluZGV4OiB1c2ItZGV2ZWwvc2NyaXB0cy9jaGVja3Bh
dGNoLnBsDQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQotLS0gdXNiLWRldmVs
Lm9yaWcvc2NyaXB0cy9jaGVja3BhdGNoLnBsDQorKysgdXNiLWRldmVsL3Nj
cmlwdHMvY2hlY2twYXRjaC5wbA0KQEAgLTY2NzMsNyArNjY3Myw3IEBAIHN1
YiBwcm9jZXNzIHsNCiAJCWlmICgkc2lnbm9mZiA9PSAwKSB7DQogCQkJRVJS
T1IoIk1JU1NJTkdfU0lHTl9PRkYiLA0KIAkJCSAgICAgICJNaXNzaW5nIFNp
Z25lZC1vZmYtYnk6IGxpbmUocylcbiIpOw0KLQkJfSBlbHNpZiAoISRhdXRo
b3JzaWdub2ZmKSB7DQorCQl9IGVsc2lmICgkYXV0aG9yIG5lICcnICYmICEk
YXV0aG9yc2lnbm9mZikgew0KIAkJCVdBUk4oIk5PX0FVVEhPUl9TSUdOX09G
RiIsDQogCQkJICAgICAiTWlzc2luZyBTaWduZWQtb2ZmLWJ5OiBsaW5lIGJ5
IG5vbWluYWwgcGF0Y2ggYXV0aG9yICckYXV0aG9yJ1xuIik7DQogCQl9DQo=
---1559625215-505712803-1568384525=:1466--
