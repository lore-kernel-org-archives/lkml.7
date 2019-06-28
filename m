Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83839C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C814208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561723989;
	bh=ONtInnwL8qsfVF9xRqfptzALN6o1MdLeVmFGHc43Xh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ql8hRAakQfNDvK28OhJ1cpcTm2HrtkbCM81YjjqoiZt53tlaI0pyeUE9qG+nHDeRn
	 zk6k5zGed8pE9u3ulXlglNhzr9hJpY3vVfnPceJ40eXWK//AGd830GmVp8fuuuUNCH
	 QsGFKyRFRZ/mZI3HZdBExOYN2ZTHxZBgHHyDxkgE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfF1MNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:13:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58262 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbfF1MMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:12:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=T+aHFn5tFUgnSfpFBnMICNi3wReCrHAynzcdOyekQxQ=; b=li3EMoqURBx6eQDmRTLWIB3EsT
        Zu6i0ZMoyMkhiaS/Xc9FEiFQdBWZ5xIb+okHKXiLjWDP29jcx01CZ1VFEd8xe24cfQg7EKFuuj/ZW
        8G4qFBnweblN0OUkI+v917d3p7X5mTEvBpwJVzzo6LJxUmZ2POQ3i/auKaU3KB+HCB+xUt5gRUGd5
        fdoArj9P5mey/eRvzL56ap3KvXszQg3Itx7S4dOVDXcEqoTHlbXBpw0OONwM9le9nNek5L9zlnmhi
        outVa4sIbOJlIWglRQhxrm7sbeVu6SVOC3j2ZtW8aqwFO0Wpdjt6JSBf1rVzg7lf6KC2P3YZOm92P
        PM2Z/KMw==;
Received: from [186.213.242.156] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgpk3-0005Ba-9t; Fri, 28 Jun 2019 12:12:35 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hgpk0-0004zX-9H; Fri, 28 Jun 2019 09:12:32 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 4/9] dt: leds-lm36274.txt: fix a broken reference to ti-lmu.txt
Date:   Fri, 28 Jun 2019 09:12:26 -0300
Message-Id: <6ac637e0394adfdc95bfc45dad6bfc7bf631fca3.1561723736.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561723736.git.mchehab+samsung@kernel.org>
References: <cover.1561723736.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a typo there:
	ti_lmu.txt -> ti-lmu.txt

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Acked-by: Pavel Machek <pavel@ucw.cz>
Acked-by: Dan Murphy <dmurphy@ti.com>
---
 Documentation/devicetree/bindings/leds/leds-lm36274.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/leds/leds-lm36274.txt b/Documentation/devicetree/bindings/leds/leds-lm36274.txt
index 456a589c65f0..39c230d59a4d 100644
--- a/Documentation/devicetree/bindings/leds/leds-lm36274.txt
+++ b/Documentation/devicetree/bindings/leds/leds-lm36274.txt
@@ -6,7 +6,7 @@ up to 29V total output voltage. The 11-bit LED current is programmable via
 the I2C bus and/or controlled via a logic level PWM input from 60 uA to 30 mA.
 
 Parent device properties are documented in
-Documentation/devicetree/bindings/mfd/ti_lmu.txt
+Documentation/devicetree/bindings/mfd/ti-lmu.txt
 
 Regulator properties are documented in
 Documentation/devicetree/bindings/regulator/lm363x-regulator.txt
-- 
2.21.0

