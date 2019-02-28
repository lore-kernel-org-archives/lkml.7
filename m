Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB9FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 655512171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="C8roOlvP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732255AbfB1J4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 04:56:20 -0500
Received: from mail-eopbgr800042.outbound.protection.outlook.com ([40.107.80.42]:15863
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726135AbfB1J4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 04:56:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=niRKNua5ytMRnMi0YdGyWWxyAj7TP6yDX+FZJ3MMJiU=;
 b=C8roOlvPv7s5d6KRtKm5ZCVnhyZSfSbCw3ubcTXgTr8DRwSmqyWQFTD5Sehy8RbXwGu0ZXqv+60SZmyoFSdKhZjpHteq1G92qhM03HAkYdcrYz4/jKevCY+aMLTg7CWAhYWcO6ldTQoaVKFiLovv/d07VvrNsZdalMXZerDvCAw=
Received: from SN1PR12MB2575.namprd12.prod.outlook.com (52.132.197.151) by
 SN1PR12MB2574.namprd12.prod.outlook.com (52.132.197.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Thu, 28 Feb 2019 09:56:16 +0000
Received: from SN1PR12MB2575.namprd12.prod.outlook.com
 ([fe80::2458:b06a:5f8d:2c6b]) by SN1PR12MB2575.namprd12.prod.outlook.com
 ([fe80::2458:b06a:5f8d:2c6b%3]) with mapi id 15.20.1643.019; Thu, 28 Feb 2019
 09:56:16 +0000
From:   "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>
To:     Wolfram Sang <wsa@the-dreams.de>, Elie Morisse <syniurge@gmail.com>
CC:     "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Singh, Sandeep" <Sandeep.Singh@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v16] i2c: Add drivers for the AMD PCIe MP2 I2C controller
Thread-Topic: [PATCH v16] i2c: Add drivers for the AMD PCIe MP2 I2C controller
Thread-Index: AQHUze4hEXLXnqA+fkKzKDkHQFv+bKXyQ1sAgAAHagCAArEBAA==
Date:   Thu, 28 Feb 2019 09:56:16 +0000
Message-ID: <360a227c-68f9-81f8-bcf4-9aeefa837cc0@amd.com>
References: <20190226161243.GA21539@syn-yoga530>
 <CAC_JBqrE_g-neObMMvsdAG4USDqgc+oqAs2y6WYRdrT6PBAiSQ@mail.gmail.com>
 <20190226165001.GD839@kunai>
In-Reply-To: <20190226165001.GD839@kunai>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR01CA0083.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00::23)
 To SN1PR12MB2575.namprd12.prod.outlook.com (2603:10b6:802:2b::23)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.157.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b6369580-b1c8-4407-1145-08d69d62fab5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB2574;
x-ms-traffictypediagnostic: SN1PR12MB2574:
x-microsoft-exchange-diagnostics: 1;SN1PR12MB2574;20:Ur8OIlwpHCH9T/0WNCRslZFTPPr3ZBTBvnxQVQLZZvSuVNRwg4x1lxPAypyxSj/uyUrryJiuGBCUr0LJISYyKsobZVRvQvYfTpf5vHp5exXl5DKq6Npt6jSpF0QNdFCOkzAIWFSyHYUPe3m0BZrEVDkO4LchU42ZHwDTSFx4UIGaI8N6XlEi2D4j6iN9tk4AIuqb2mXSuVSnwxaBj4xHs7gu3zTaZw+sKqX0v48ZYh5Z4xgHj4eU9BfOTy33Pq/p
x-microsoft-antispam-prvs: <SN1PR12MB2574EE088A820061D8314B5DA0750@SN1PR12MB2574.namprd12.prod.outlook.com>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(396003)(136003)(346002)(189003)(199004)(51914003)(71200400001)(6506007)(11346002)(6346003)(386003)(2616005)(36756003)(5660300002)(97736004)(76176011)(72206003)(256004)(68736007)(486006)(14444005)(53546011)(102836004)(52116002)(99286004)(446003)(31686004)(14454004)(6246003)(476003)(26005)(25786009)(86362001)(478600001)(105586002)(4326008)(31696002)(106356001)(186003)(305945005)(6486002)(54906003)(7736002)(6436002)(3846002)(4744005)(8676002)(110136005)(6116002)(8936002)(66066001)(53936002)(6512007)(81156014)(2906002)(229853002)(316002)(81166006)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB2574;H:SN1PR12MB2575.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nehal-bakulchandra.Shah@amd.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 96Xb/Pib/yiH70ghijPWrMmumCMZvIsqV+Yo96Dz1dZSrq6rdcGGzZUw6elbJD6utNe80btItIPsK4P6gjLlzR9ce66Y/OUrYPJQVb7cLQ58yh8OJgQiag3w53eOTkAQkUu0V8+GU6kw2rFO7hyEuJ1GYVtrMHm87KcPHCQheo6s2Mv6zEc8X5pCeJHWSOtJMzQ1+XUt6kike+0juKdfKedywmIXJN+rmnPvecOjbZU54OspEYE8LTgbxTLoe0OTSHSrVQbLy5kz2g7YrSUz087WOV7VK6NcXrOGiXDCPltdF0f63Mnn6sVI3h1I6VOtJNy40ZpbYo7x3KgMxL3FdsRZnh3WsN2S2l192FquiCe1tXTMqy8xe0QzhgnLZvEfvOv3EFgBoFXwYyznL+SEWoUH7NEQvdHkp/2JMLrk4Gk=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <9822404167586D49A0494CEABEFCA6CE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6369580-b1c8-4407-1145-08d69d62fab5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 09:56:13.8506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2574
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Elie,

On 2/26/2019 10:20 PM, Wolfram Sang wrote:
> Hi Elie,
>=20
>> My apologies for the time it took to apply those changes.
>=20
> No worries. I am super happy that you are still around and willing to
> continue the work!
>=20
>> I will also start working on an alternate (v17?) version with only one
>> module and replacing the platform driver by an ACPI lookup as
>> requested by Bjorn Helgaas, unless Nehal clarifies how AMD plans to
>> expand the platform driver.
>=20
> Sounds really good to me.

Thanks for the patch. For our upcoming sensor hub design we need MP2-PCIE a=
s independent driver.Hence i am requesting to keep the two separate modules=
.
> Thanks,
>=20
>    Wolfram
>=20

Regards
Nehal Shah
