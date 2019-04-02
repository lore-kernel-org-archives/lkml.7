Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0963C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 17:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BA4D2070B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 17:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gMmDkaBl";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="dBKmMavn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731175AbfDBRYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 13:24:37 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65123 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfDBRYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 13:24:37 -0400
X-Greylist: delayed 344 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Apr 2019 13:24:35 EDT
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CCE3652B34;
        Tue,  2 Apr 2019 13:18:50 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:mime-version:content-type; s=sasl; bh=lA3
        XXJppY4E0zdXkUf0okQrIzCE=; b=gMmDkaBlDeGNluwVGaKQXZ4Vr6pDd/igfxx
        OdHyDVRzzgVdaMhFKgR48aK3zFSvKldvptxXDXz+iEyPwMqbqUkiUF9u9oCLkNHD
        hcXs7SJy0S3JzuRiylb6f/MRNiaDm3RlemkPWC1BvO/hBITV2+FECUfyNBxIGDy+
        bM7mhFPw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C623C52B32;
        Tue,  2 Apr 2019 13:18:50 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:message-id:mime-version:content-type;
 s=2016-12.pbsmtp; bh=QJmCaYAwqEZuZmTZNPGtDIFJtseNCPGm4fIWacmp1jM=;
 b=dBKmMavn4vghKi0tg9B7oFGqJIJU3K6LTLQMYcvYo+OmXudG5rqASbCSplXU/Ruv457NY5xBxvyRHpzvLwa3nHquUQXxwp5CkaJHzqZqhfOSLfPod9xWaunMl7an9yIZPiUvl6iGHQYE+V0hfssPU8Di4U0o34m3t4iyufBFBVw=
Received: from yoda.home (unknown [70.82.104.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A944B52B31;
        Tue,  2 Apr 2019 13:18:47 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id B296E2DA0416;
        Tue,  2 Apr 2019 13:18:45 -0400 (EDT)
Date:   Tue, 2 Apr 2019 13:18:45 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org, nico@linaro.org
Subject: [PATCH] update my email address
Message-ID: <nycvar.YSQ.7.76.1904021315560.20244@knanqh.ubzr>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 604D773E-556B-11E9-A255-D01F9763A999-78420484!pb-smtp20.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The @linaro version won't be valid much longer.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>

diff --git a/.mailmap b/.mailmap
index b2cde8668d..ae2bcad06f 100644
--- a/.mailmap
+++ b/.mailmap
@@ -156,6 +156,8 @@ Morten Welinder <welinder@darter.rentec.com>
 Morten Welinder <welinder@troll.com>
 Mythri P K <mythripk@ti.com>
 Nguyen Anh Quynh <aquynh@gmail.com>
+Nicolas Pitre <nico@fluxnic.net> <nicolas.pitre@linaro.org>
+Nicolas Pitre <nico@fluxnic.net> <nico@linaro.org>
 Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
 Patrick Mochel <mochel@digitalimplant.org>
 Paul Burton <paul.burton@mips.com> <paul.burton@imgtec.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 43b36dbed4..391405091c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4129,7 +4129,7 @@ F:	drivers/cpuidle/*
 F:	include/linux/cpuidle.h
 
 CRAMFS FILESYSTEM
-M:	Nicolas Pitre <nico@linaro.org>
+M:	Nicolas Pitre <nico@fluxnic.net>
 S:	Maintained
 F:	Documentation/filesystems/cramfs.txt
 F:	fs/cramfs/
