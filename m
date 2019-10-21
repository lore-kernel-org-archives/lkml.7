Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C38CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 19:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 689832086D
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 19:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="K6UDTZNu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730048AbfJUTtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 15:49:17 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:29634 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728543AbfJUTtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 15:49:16 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9LJnDt0008602
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 12:49:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=uMPLZudvHw0j6sIKfNqOlx3Nki++v8QXEdIUUJe1BFI=;
 b=K6UDTZNuiriKj4IUNnFY+YcJAv6qD6Mp3tIPVNwx06ynkCYc7iKrcSN6Sy17hFDpBMZy
 NwLc4XJwhS1VjHTos2fEdxYAluNVkdLG+lvNn3KGREED3ty1nav3gTbMU+VQbE110rvX
 C7ayHO7i023WbUjNtKaRAfKLKWTxzbppVrY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vshwr8bpw-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 12:49:15 -0700
Received: from 2401:db00:12:9028:face:0:29:0 (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 21 Oct 2019 12:49:05 -0700
Received: by devvm1794.vll1.facebook.com (Postfix, from userid 150176)
        id B14F864C3C92; Mon, 21 Oct 2019 12:49:03 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Tao Ren <taoren@fb.com>
Smtp-Origin-Hostname: devvm1794.vll1.facebook.com
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <openbmc@lists.ozlabs.org>
CC:     Tao Ren <taoren@fb.com>
Smtp-Origin-Cluster: vll1c12
Subject: [PATCH 0/4] ARM: dts: aspeed: add dtsi for Facebook AST2500 Network BMCs
Date:   Mon, 21 Oct 2019 12:48:16 -0700
Message-ID: <20191021194820.293556-1-taoren@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-21_05:2019-10-21,2019-10-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=550
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0 mlxscore=0
 spamscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1910210190
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch series adds "facebook-netbmc-ast2500-common.dtsi" which defines
devices that are common cross all Facebook AST2500 Network BMC platforms.
The major purpose is to minimize duplicated device entries among Facebook
Network BMC dts files.

Patch #1 (of 4) adds "facebook-netbmc-ast2500-common.dtsi" file, and the
remaining 3 patches update CMM, Minipack and Yamp device tree to consume
the new dtsi file.

Tao Ren (4):
  ARM: dts: aspeed: add dtsi for Facebook AST2500 Network BMCs
  ARM: dts: aspeed: cmm: include dtsi for common network BMC devices
  ARM: dts: aspeed: minipack: include dtsi for common network BMC
    devices
  ARM: dts: aspeed: yamp: include dtsi for common network BMC devices

 arch/arm/boot/dts/aspeed-bmc-facebook-cmm.dts | 66 ++++---------
 .../boot/dts/aspeed-bmc-facebook-minipack.dts | 59 ++++--------
 .../arm/boot/dts/aspeed-bmc-facebook-yamp.dts | 62 +-----------
 .../dts/facebook-netbmc-ast2500-common.dtsi   | 96 +++++++++++++++++++
 4 files changed, 136 insertions(+), 147 deletions(-)
 create mode 100644 arch/arm/boot/dts/facebook-netbmc-ast2500-common.dtsi

-- 
2.17.1

