Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21EC5C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 22:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E867620880
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 22:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392392AbfHBWFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 18:05:09 -0400
Received: from smtprelay0102.hostedemail.com ([216.40.44.102]:48139 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729311AbfHBWFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 18:05:09 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 669D7100E806B;
        Fri,  2 Aug 2019 22:05:07 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: swing93_49a7a4bebce5e
X-Filterd-Recvd-Size: 2071
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Fri,  2 Aug 2019 22:05:06 +0000 (UTC)
Message-ID: <2ecfbf8dda354fe47912446bf5c3fe30ca905aa0.camel@perches.com>
Subject: Re: [PATCH] isdn: hysdn: Fix error spaces around '*'
From:   Joe Perches <joe@perches.com>
To:     Stephen Hemminger <stephen@networkplumber.org>,
        Jose Carlos Cazarin Filho <joseespiriki@gmail.com>
Cc:     isdn@linux-pingi.de, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 02 Aug 2019 15:05:05 -0700
In-Reply-To: <20190802145506.168b576b@hermes.lan>
References: <20190802195602.28414-1-joseespiriki@gmail.com>
         <20190802145506.168b576b@hermes.lan>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-08-02 at 14:55 -0700, Stephen Hemminger wrote:
> On Fri,  2 Aug 2019 19:56:02 +0000
> Jose Carlos Cazarin Filho <joseespiriki@gmail.com> wrote:
> 
> > Fix checkpath error:
> > CHECK: spaces preferred around that '*' (ctx:WxV)
> > +extern hysdn_card *card_root;        /* pointer to first card */
> > 
> > Signed-off-by: Jose Carlos Cazarin Filho <joseespiriki@gmail.com>
> 
> Read the TODO, these drivers are scheduled for removal, so changes
> are not helpful at this time.

Maybe better to mark the MAINTAINERS entry obsolete so
checkpatch bleats a message about unnecessary changes.
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 30bf852e6d6b..b5df91032574 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8628,7 +8628,7 @@ M:	Karsten Keil <isdn@linux-pingi.de>
 L:	isdn4linux@listserv.isdn4linux.de (subscribers-only)
 L:	netdev@vger.kernel.org
 W:	http://www.isdn4linux.de
-S:	Odd Fixes
+S:	Obsolete
 F:	Documentation/isdn/
 F:	drivers/isdn/capi/
 F:	drivers/staging/isdn/

