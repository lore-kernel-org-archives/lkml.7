Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71F4C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC95A206BF
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="tWSbMhUx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbfH0MTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 08:19:51 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:55980 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726596AbfH0MTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 08:19:50 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7RC6odm017691;
        Tue, 27 Aug 2019 14:19:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=STMicroelectronics;
 bh=jmXRhIE8q+Sed7f9WiZAUW4GbJ4tUfk7sqSvhf1B3xw=;
 b=tWSbMhUxOcUa7IXi/+0gVCq61TsIBEaiL01X4EURsI/nyBZg39ganAiugp279ZTR6Wp1
 9B999Prv5z3C6LXligMToI4Qp1j/zzFcvfJOH/0ZbQ72Qt1rCydaqAjlNBLgb9agrZoH
 T6VfkLZw/ywI6PST2MAagFbtGgQRcAc1UBe+jQWPIUoORXRoARBuy/ICtcgkF21kTc4x
 1uWHEXHNX6pi5HobGjJvb+wxk87YbTg9O6zr8CaiD/thxQw7GMjxpINQM6rKWnhLAYxt
 UAXzlK8Cc0sC5VeJUPnGqSB1kZFkYH5XIjU/54tdi7m7QSiQ+EvjiM6NviK7tRXJdBtE iQ== 
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
        by mx08-00178001.pphosted.com with ESMTP id 2ujv4ksbxh-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 27 Aug 2019 14:19:37 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 8E95353;
        Tue, 27 Aug 2019 12:19:33 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node1.st.com [10.75.127.13])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 461EE2CA731;
        Tue, 27 Aug 2019 14:19:33 +0200 (CEST)
Received: from SFHDAG5NODE1.st.com (10.75.127.13) by SFHDAG5NODE1.st.com
 (10.75.127.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 27 Aug
 2019 14:19:32 +0200
Received: from SFHDAG5NODE1.st.com ([fe80::cc53:528c:36c8:95f6]) by
 SFHDAG5NODE1.st.com ([fe80::cc53:528c:36c8:95f6%20]) with mapi id
 15.00.1473.003; Tue, 27 Aug 2019 14:19:32 +0200
From:   Gerald BAEZA <gerald.baeza@st.com>
To:     "corbet@lwn.net" <corbet@lwn.net>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Gerald BAEZA <gerald.baeza@st.com>
Subject: [PATCH] Documentation: add link to stm32mp157 docs
Thread-Topic: [PATCH] Documentation: add link to stm32mp157 docs
Thread-Index: AQHVXNGu+WgWi0gJwE+sfJwWkTflzQ==
Date:   Tue, 27 Aug 2019 12:19:32 +0000
Message-ID: <1566908347-92201-1-git-send-email-gerald.baeza@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.47]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-27_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Link to the online stm32mp157 documentation added
in the overview.

Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
---
 Documentation/arm/stm32/stm32mp157-overview.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/arm/stm32/stm32mp157-overview.rst b/Documentatio=
n/arm/stm32/stm32mp157-overview.rst
index f62fdc8..8d5a476 100644
--- a/Documentation/arm/stm32/stm32mp157-overview.rst
+++ b/Documentation/arm/stm32/stm32mp157-overview.rst
@@ -14,6 +14,12 @@ It features:
 - Standard connectivity, widely inherited from the STM32 MCU family
 - Comprehensive security support
=20
+Resources
+---------
+
+Datasheet and reference manual are publicly available on ST website:
+.. _STM32MP157: https://www.st.com/en/microcontrollers-microprocessors/stm=
32mp157.html
+
 :Authors:
=20
 - Ludovic Barre <ludovic.barre@st.com>
--=20
2.7.4
