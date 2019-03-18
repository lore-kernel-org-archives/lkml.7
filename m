Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44C9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A32A320872
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="AJg39VOL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfCRPO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:14:29 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:26349 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbfCRPO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 11:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1552922065;
        s=strato-dkim-0002; d=goldelico.com;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=KbXkbKAm+c5G4i5FvJHyS01NPWk4HhqfUYz6Dcc8NVY=;
        b=AJg39VOLll1MDg1zVlNom94V5AuSE3pcQaFeHGHBpcaWt1BUtsMEcCCLDkLMZENt2i
        FT/G9y24tL+l6ojpKd0nqyHj+FohfZXfZXxVdFvTUCqKGUYiGHQoZbrYwL7Xn4FzFK7o
        ere2RjCIxwuhGQZNX5W/0rqG+7ZD2J3PppEOFcoTsr+COF2rRMclf7YaLCiDXNMwvW8x
        vbQmI9xvTdn+dvk/jUgrOLVDjl50KHoAZqVxQaj2HcgaQJuR012wwsJ5kYLszwKdAzKO
        nRxdWs4H2t/1/aYP38kt7G6OwpITSHrNwpB1OcLM6Q4sKpFPfbw35Oj2RqZOlU29rcEV
        friA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UNf2M7O2CKNdGj"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 44.16 DYNA|AUTH)
        with ESMTPSA id h04075v2IFEGEjh
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 18 Mar 2019 16:14:16 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com
Subject: [PATCH 0/2] iio: gyro: bmg160 add device tree support
Date:   Mon, 18 Mar 2019 16:14:13 +0100
Message-Id: <cover.1552922054.git.hns@goldelico.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no device tree support since the of_device_id table is missing.

H. Nikolaus Schaller (2):
  iio: gyro: bmg160: add device tree compatibility table
  dt-bindings: iio: add Bosch BMG160 gyroscope sensor

 .../bindings/iio/gyroscope/bmg160.txt         | 20 +++++++++++++++++++
 drivers/iio/gyro/bmg160_i2c.c                 |  9 +++++++++
 2 files changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/bmg160.txt

-- 
2.19.1

