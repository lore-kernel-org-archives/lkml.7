Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A279CA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 03:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C965D21925
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 03:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="sfiCYFCs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408295AbfJXDCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 23:02:41 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:58795 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406494AbfJXDCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 23:02:41 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 54A74806A8;
        Thu, 24 Oct 2019 16:02:39 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1571886159;
        bh=bcR01ip7IVRZdB2jx0X5ZSOXTyf/0QyKPLOZ2KZEnFA=;
        h=From:To:Cc:Subject:Date;
        b=sfiCYFCsxyoZSW8CYJVObswJNren62/sOaXA9o31XNd4fskszACZdy1A8G9S4w2+J
         DDhhc7rX5WNHrDwajonKtqX7UZWqW1Nzz5gIJMymDrOREx1mekcLdVyAVTJ3EkY82l
         97F5dcshXTmEYqVqayN9dGGoUvS5srjlzVuvPliyts3OcHiS5O9wtsQeu528Ir1Ox9
         K8Jbate0cd75hiF+0lPV1adUMd7gnf1RHN/CQGBqn/NolWHPQ9mI7HwmlxcWztLDjh
         gHU7aCiXXG5+dS5U36RsOb0UyGtBH9qo89AwLwpaBKJX6A/f3Ur+HeunnkHGOvEFNO
         UoJaHymT1nFwg==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5db1144d0000>; Thu, 24 Oct 2019 16:02:38 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id 6C09013EF6D;
        Thu, 24 Oct 2019 16:02:41 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 3A0F528005C; Thu, 24 Oct 2019 16:02:37 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     frowand.list@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        corbet@lwn.net
Cc:     devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Subject: [RESEND PATCH] of: Documentation: Correct return value from of_overlay_fdt_apply
Date:   Thu, 24 Oct 2019 16:02:29 +1300
Message-Id: <20191024030230.8275-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return from of_overlay_fdt_apply() just indicates success or fail.
The cookie is returned via reference.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
Just going over some old branches and saw this hadn't been picked up. I w=
onder
if it got caught between maintainers.

Review from Frank:
https://lore.kernel.org/lkml/9bb707be-9cb3-dffc-303f-ee7025090ba9@gmail.c=
om/

 Documentation/devicetree/overlay-notes.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/overlay-notes.txt b/Documentation/d=
evicetree/overlay-notes.txt
index 725fb8d255c1..62f2003d6205 100644
--- a/Documentation/devicetree/overlay-notes.txt
+++ b/Documentation/devicetree/overlay-notes.txt
@@ -88,7 +88,8 @@ Overlay in-kernel API
 The API is quite easy to use.
=20
 1. Call of_overlay_fdt_apply() to create and apply an overlay changeset.=
 The
-return value is an error or a cookie identifying this overlay.
+return indicates success or failure. A a cookie identifying this overlay=
 is
+returned via reference on success.
=20
 2. Call of_overlay_remove() to remove and cleanup the overlay changeset
 previously created via the call to of_overlay_fdt_apply(). Removal of an
--=20
2.23.0

