Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EB3C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 18:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D39214AE
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 18:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559933687;
	bh=cOnr9cD0bU96kABaEzgXc3vrNs1wra7Rvj4pZ0fcnzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BMazYOY1eJydBP3TOtN6k0BQmg18jasOdxGb+E8teVT5qlvMyPjEwUzwO6X4VxTSj
	 HQo5vrFvVNpMHkZibG1qAbcUGtFTlIH/rIbC4nhY3xICK3id0IDaSEmJBbi0Mkujic
	 Jb6xHVN0D4dcUIFygpVVx9EPv66At+ovLwYypWDI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732189AbfFGSyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 14:54:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42278 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732020AbfFGSyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 14:54:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1DGih5hxjM3hCpgxfZAZGkcczMEB+Oahf4kiHIhmR2E=; b=SXK57easNH7SfIUqyKz4xhMsU5
        udP2ES3k6OtlzMX8JGKA8bhEh3+dBs1+L+pPAapcSmJ1A81chR4p8/ygQuuSix2NfhcyJHsbv4VNm
        HfekxYamdvW9ifZuxrIW27hLlbmhlFv8ZPJ4z3cR0zQ3xNjj0jhz3xnr0LPi/G7qwYL07j8KNti2e
        2inHVFGxUkuanWm0uFB1gyezmncCwmYZ3obYDBUG7KArD57WZ6NX+MyqAHSPafTj08e3cHXN8j08v
        33zQZKkO1727F6dTtJBxaeDFzUbWGbsdsZCRymKYzJ0+AwGF2WeSm8i+3oqM1Q7WV9+/6C+tDhX6o
        Mm95osdA==;
Received: from [179.181.119.115] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hZK0d-0005sc-K4; Fri, 07 Jun 2019 18:54:39 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hZK0b-0007EW-84; Fri, 07 Jun 2019 15:54:37 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Karsten Keil <isdn@linux-pingi.de>, netdev@vger.kernel.org
Subject: [PATCH v3 02/20] isdn: mISDN: remove a bogus reference to a non-existing doc
Date:   Fri,  7 Jun 2019 15:54:18 -0300
Message-Id: <299de18e779eef2eed678d799568d65464f45903.1559933665.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <ff457774d46d96e8fe56b45409aba39d87a8672a.1559933665.git.mchehab+samsung@kernel.org>
References: <ff457774d46d96e8fe56b45409aba39d87a8672a.1559933665.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mISDN driver was added on those commits:

	960366cf8dbb ("Add mISDN DSP")
	1b2b03f8e514 ("Add mISDN core files")
	04578dd330f1 ("Define AF_ISDN and PF_ISDN")
	e4ac9bc1f668 ("Add mISDN driver")

None of them added a Documentation/isdn/mISDN.cert file.
Also, whatever were supposed to be written there on that time,
probably doesn't make any sense nowadays, as I doubt isdn would
have any massive changes.

So, let's just get rid of the broken reference, in order to
shut up a warning produced by ./scripts/documentation-file-ref-check.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 drivers/isdn/mISDN/dsp_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/isdn/mISDN/dsp_core.c b/drivers/isdn/mISDN/dsp_core.c
index cd036e87335a..038e72a84b33 100644
--- a/drivers/isdn/mISDN/dsp_core.c
+++ b/drivers/isdn/mISDN/dsp_core.c
@@ -4,8 +4,6 @@
  *		Karsten Keil (keil@isdn4linux.de)
  *
  *		This file is (c) under GNU PUBLIC LICENSE
- *		For changes and modifications please read
- *		../../../Documentation/isdn/mISDN.cert
  *
  * Thanks to    Karsten Keil (great drivers)
  *              Cologne Chip (great chips)
-- 
2.21.0

