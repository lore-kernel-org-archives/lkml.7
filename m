Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DBAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 23:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5007B20857
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 23:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="UpUgajFw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfCSXSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 19:18:32 -0400
Received: from mail-eopbgr810131.outbound.protection.outlook.com ([40.107.81.131]:58341
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727410AbfCSXSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 19:18:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQvcchuMqktmAIpZZTISIb7jFlFAc7ubcKebQDH9tcg=;
 b=UpUgajFwKtEN5f35YUYEGKfcFKYlSAxtvogaDo0QudXBgaqVQBzXWxjCAX9dMJvCokAunT4CKwBhIS56LqfTClVFBrnRCL/HDhVva5QiTm3P2RQrLD8W9QxCLK1SkaS5uHsldq1ynlZjvIaMOspZ23AC0cW5wwVflEBlEIZgUDs=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1741.namprd22.prod.outlook.com (10.164.206.159) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.15; Tue, 19 Mar 2019 23:18:28 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b8d4:8f0d:d6d1:4018]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b8d4:8f0d:d6d1:4018%3]) with mapi id 15.20.1709.015; Tue, 19 Mar 2019
 23:18:28 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hauke@hauke-m.de" <hauke@hauke-m.de>,
        "zajec5@gmail.com" <zajec5@gmail.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH] arch: mips: Kconfig: pedantic formatting
Thread-Topic: [PATCH] arch: mips: Kconfig: pedantic formatting
Thread-Index: AQHU2CK5aivYPLv4c02Y+zp0m3/qh6YTo9eA
Date:   Tue, 19 Mar 2019 23:18:28 +0000
Message-ID: <MWHPR2201MB12777101F00768CAEE4D43C7C1400@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <1552319667-5811-1-git-send-email-info@metux.net>
In-Reply-To: <1552319667-5811-1-git-send-email-info@metux.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR21CA0008.namprd21.prod.outlook.com
 (2603:10b6:a03:114::18) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a8b2569-2348-466c-3219-08d6acc13196
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1741;
x-ms-traffictypediagnostic: MWHPR2201MB1741:
x-microsoft-antispam-prvs: <MWHPR2201MB1741D848F4187EADBA8743F6C1400@MWHPR2201MB1741.namprd22.prod.outlook.com>
x-forefront-prvs: 0981815F2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(136003)(346002)(39850400004)(376002)(199004)(189003)(68736007)(446003)(316002)(105586002)(256004)(71190400001)(66066001)(7736002)(486006)(25786009)(97736004)(74316002)(54906003)(106356001)(71200400001)(52536014)(305945005)(4326008)(6916009)(52116002)(5660300002)(6506007)(33656002)(102836004)(11346002)(6436002)(2906002)(14454004)(4744005)(229853002)(55016002)(6116002)(26005)(386003)(186003)(478600001)(99286004)(8676002)(3846002)(476003)(7696005)(44832011)(81156014)(76176011)(81166006)(8936002)(53936002)(9686003)(1250700005)(6246003)(42882007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1741;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sXHrMpUUx9EyX+XJ4Jlg96V7kAR6eUQWKflrRbFMTPcSSbR49bWI7JFqFaP/6HTSG/Zu6siDrCdaYf/UsqzMYNAt+TUXgyc5me99rQFYtYs2M3dyYrbwpyWSpx/ilgYN9LtMY5GQ7BSoGynixTtdd7DnBlCfORnB6hvD6IMNSAcksHX2sgCum8SZB1r+1KM7fjcw89CLPpoNhHE7YBvdbYiwaSGl95npeCa2RWqm/0fdO32aAmi7Knk3uzZu4UzOjQ8MzptUxD/D/BV4Q+SoNAuOrfVxtKripZX3TSfxzDIUUiJ0zxFPg5hb3LZoRZ5qX/cqtKMYhkIDlpxEfVzbbuN3D5MMcAb8U5BZX6QgdkVB07UDP5A486KyT1JUIggEkao6zakO5k3tQk8VKqa/BlCBmwoI/ILhMVacHWsrR3k=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a8b2569-2348-466c-3219-08d6acc13196
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2019 23:18:28.4690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Enrico Weigelt, metux IT consult wrote:
> Formatting of Kconfig files doesn't look so pretty, so let the
> Great White Handkerchief come around and clean it up.
>=20
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

Applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
