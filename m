Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30644C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 03:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DE2D2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 03:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbfH0DlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 23:41:06 -0400
Received: from smtprelay0147.hostedemail.com ([216.40.44.147]:35302 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728025AbfH0DlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 23:41:05 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 0F6B31802E6D6;
        Tue, 27 Aug 2019 03:41:04 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: sofa02_2639caa3ebe21
X-Filterd-Recvd-Size: 2243
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Tue, 27 Aug 2019 03:41:02 +0000 (UTC)
Message-ID: <877726fc009ee5ffde50e589d332db90c9695f06.camel@perches.com>
Subject: Re: [PATCH] net: intel: Cleanup e1000 - add space between }}
From:   Joe Perches <joe@perches.com>
To:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Forrest Fleming <ffleming@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 26 Aug 2019 20:41:00 -0700
In-Reply-To: <c2279a78904b581924894b712403299903eacbfc.camel@intel.com>
References: <20190823191421.3318-1-ffleming@gmail.com>
         <c2279a78904b581924894b712403299903eacbfc.camel@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-08-26 at 01:03 -0700, Jeff Kirsher wrote:
> On Fri, 2019-08-23 at 19:14 +0000, Forrest Fleming wrote:
> > suggested by checkpatch
> > 
> > Signed-off-by: Forrest Fleming <ffleming@gmail.com>
> > ---
> >  .../net/ethernet/intel/e1000/e1000_param.c    | 28 +++++++++----------
> >  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> While I do not see an issue with this change, I wonder how important it is
> to make such a change.  Especially since most of the hardware supported by
> this driver is not available for testing.  In addition, this is one
> suggested change by checkpatch.pl that I personally do not agree with.

I think checkpatch should allow consecutive }}.

Maybe:
---
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 287fe73688f0..ac5e0f06e1af 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -4687,7 +4687,7 @@ sub process {
 
 # closing brace should have a space following it when it has anything
 # on the line
-		if ($line =~ /}(?!(?:,|;|\)))\S/) {
+		if ($line =~ /}(?!(?:,|;|\)|\}))\S/) {
 			if (ERROR("SPACING",
 				  "space required after that close brace '}'\n" . $herecurr) &&
 			    $fix) {


