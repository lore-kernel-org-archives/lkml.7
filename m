Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD71C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 16:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8F5C20836
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 16:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfCBQ5A convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 11:57:00 -0500
Received: from mail-oln040092066095.outbound.protection.outlook.com ([40.92.66.95]:46725
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726239AbfCBQ47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 11:56:59 -0500
Received: from VE1EUR01FT050.eop-EUR01.prod.protection.outlook.com
 (10.152.2.54) by VE1EUR01HT124.eop-EUR01.prod.protection.outlook.com
 (10.152.3.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1643.21; Sat, 2 Mar
 2019 16:56:56 +0000
Received: from AM3PR03MB0966.eurprd03.prod.outlook.com (10.152.2.51) by
 VE1EUR01FT050.mail.protection.outlook.com (10.152.3.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.21 via Frontend Transport; Sat, 2 Mar 2019 16:56:56 +0000
Received: from AM3PR03MB0966.eurprd03.prod.outlook.com
 ([fe80::8011:1f4d:3804:e5f3]) by AM3PR03MB0966.eurprd03.prod.outlook.com
 ([fe80::8011:1f4d:3804:e5f3%10]) with mapi id 15.20.1665.015; Sat, 2 Mar 2019
 16:56:56 +0000
From:   Jonas Karlman <jonas@kwiboo.se>
To:     "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>
CC:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/3] Add leds, ir and fix regulator name on rk3328-rock64
Thread-Topic: [PATCH 0/3] Add leds, ir and fix regulator name on rk3328-rock64
Thread-Index: AQHU0RjxRRMvqsBpHEGkdOSu3uoINQ==
Date:   Sat, 2 Mar 2019 16:56:56 +0000
Message-ID: <AM3PR03MB0966DCE9C7BD0D0191467EFDAC770@AM3PR03MB0966.eurprd03.prod.outlook.com>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR0502CA0024.eurprd05.prod.outlook.com
 (2603:10a6:209:1::37) To AM3PR03MB0966.eurprd03.prod.outlook.com
 (2a01:111:e400:884c::23)
x-incomingtopheadermarker: OriginalChecksum:11C10187E4D734D8D6E7748C929A313BEA5E1A1CD192E4D28C14A7800F117662;UpperCasedChecksum:968601071ACCEE9C26634031D9ED733C8F263CEE992EC0C38A9D0E8FC2368C0D;SizeAsReceived:7712;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-tmn:  [lpvQWYU2gzJnkCiLS1QsU+EzJjwfa5On]
x-microsoft-original-message-id: <20190302165641.10905-1-jonas@kwiboo.se>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322404)(2017031323274)(2017031324274)(1601125500)(1603101475)(1701031045);SRVR:VE1EUR01HT124;
x-ms-traffictypediagnostic: VE1EUR01HT124:
x-microsoft-antispam-message-info: qWJuPXd7hjmV0N9lgh74V1zbUhbclTn3Daly/HZsAAaMOgtk9Nbj1kz1P5YeXWnH
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad92d6c-368c-484d-9d40-08d69f301393
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2019 16:56:56.2637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR01HT124
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes two regulator names and adds nodes to
enable use of leds and ir on Rock64.

Jonas Karlman (3):
  arm64: dts: rockchip: fix regulator name on rk3328-rock64
  arm64: dts: rockchip: add leds node on rk3328-rock64
  arm64: dts: rockchip: add ir-receiver node on rk3328-rock64

 .../arm64/boot/dts/rockchip/rk3328-rock64.dts | 33 +++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

-- 
2.17.1

