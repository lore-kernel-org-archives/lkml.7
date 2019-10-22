Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058B2CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 21:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE3B620B7C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 21:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="LmmTQzot"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732602AbfJVVOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 17:14:52 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:55690 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732128AbfJVVOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 17:14:51 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 7C6F6806A8;
        Wed, 23 Oct 2019 10:14:46 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1571778886;
        bh=SxH4tlf7juDU6gIpEkcqu/UiieFGp4IHnpHVYWH057I=;
        h=From:To:Cc:Subject:Date;
        b=LmmTQzotw/XsCt4M89bdY/wV+NEJ+2ttMVvhyaRThcgPECOq4G1U2RJJmkWwoa9hD
         eIvG79KNaPlj/LZ9zHXDc8hUiWQ+tYI3FEMvBgU69Brc/0bQscpj5Tk09jIUUsN7zF
         2qwO3KidGe8UEpNKm5tXGnXCH2hAotvDbYMslIpVUe6qHFXyEGXWv+CtYlgTgW360R
         nOFuNBIxHYSGtMQdXlVvWiHbjksUKXfOqRQXctTMCbiXQaCjOYDMOd1O9zrL0fKIMo
         eM1YbnN2+N4nuREb+B0qPPH0vSIpX4IbeP8WRbUK7vjZkmxMh78sbqHPnmSZxshLPY
         SSfbC6FgRbKjw==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5daf71460000>; Wed, 23 Oct 2019 10:14:46 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id 4D82B13EED4;
        Wed, 23 Oct 2019 10:14:50 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 2051E280059; Wed, 23 Oct 2019 10:14:46 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2 0/2] docs/core-api: memory-allocation: minor cleanups
Date:   Wed, 23 Oct 2019 10:14:36 +1300
Message-Id: <20191022211438.3938-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up some formatting and add references to helpers for calculating si=
zes
safely.

Chris Packham (2):
  docs/core-api: memory-allocation: remove uses of c:func:
  docs/core-api: memory-allocation: mention size helpers

 Documentation/core-api/memory-allocation.rst | 50 ++++++++++----------
 1 file changed, 24 insertions(+), 26 deletions(-)

--=20
2.23.0

