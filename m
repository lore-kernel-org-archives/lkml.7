Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880B3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF60218FC
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NsrXz9zM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbfCVQdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 12:33:53 -0400
Received: from mail-eopbgr730058.outbound.protection.outlook.com ([40.107.73.58]:46272
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726276AbfCVQdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 12:33:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LOK/WF3Ig3pAyFTLCN+YyDXhOg9/mSVYR+OGDie5wBU=;
 b=NsrXz9zMmjE8AOOvWl4THngGZDhQkeWEvkkCl/q+FHLBxAYgybZk55oQfA3HuzhgS56jMCqfrJZPovO84XoGZ2TP5wBmTuvjFih1k1O4YXNDLZjjwzro/uG+TRKLuij3Qx+bGPdxm5f054OTi+XoSOm7Yu4wJJ7JIbY7hz6u0dI=
Received: from CY4PR12MB1798.namprd12.prod.outlook.com (10.175.59.9) by
 CY4PR12MB1143.namprd12.prod.outlook.com (10.168.164.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Fri, 22 Mar 2019 16:33:49 +0000
Received: from CY4PR12MB1798.namprd12.prod.outlook.com
 ([fe80::5d25:2544:ed88:de0d]) by CY4PR12MB1798.namprd12.prod.outlook.com
 ([fe80::5d25:2544:ed88:de0d%12]) with mapi id 15.20.1730.017; Fri, 22 Mar
 2019 16:33:49 +0000
From:   Kim Phillips <kphillips@amd.com>
To:     "bp@alien8.de" <bp@alien8.de>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/6] EDAC/amd64: Add Family 17h Model 30h PCI IDs
Thread-Topic: [PATCH v3 1/6] EDAC/amd64: Add Family 17h Model 30h PCI IDs
Thread-Index: AQHU4M0FvsVTYuIABkSpR+fg/7o7Qw==
Date:   Fri, 22 Mar 2019 16:33:48 +0000
Message-ID: <ca64e38b-b374-288e-1399-c8e8598fc91c@amd.com>
References: <20190228153558.127292-1-Yazen.Ghannam@amd.com>
 <SN6PR12MB2639CDDA70C504DFEF5EE7B8F8420@SN6PR12MB2639.namprd12.prod.outlook.com>
In-Reply-To: <SN6PR12MB2639CDDA70C504DFEF5EE7B8F8420@SN6PR12MB2639.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR06CA0035.namprd06.prod.outlook.com
 (2603:10b6:805:8e::48) To CY4PR12MB1798.namprd12.prod.outlook.com
 (2603:10b6:903:11a::9)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kim.phillips@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f92f1a02-854e-454a-f6ce-08d6aee42936
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:CY4PR12MB1143;
x-ms-traffictypediagnostic: CY4PR12MB1143:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <CY4PR12MB1143A26308F61157C78322F387430@CY4PR12MB1143.namprd12.prod.outlook.com>
x-forefront-prvs: 09840A4839
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(396003)(376002)(366004)(13464003)(199004)(189003)(476003)(6246003)(53546011)(6506007)(6436002)(68736007)(106356001)(386003)(1730700003)(2906002)(2501003)(6916009)(81166006)(8676002)(8936002)(256004)(14454004)(966005)(6116002)(3846002)(66066001)(31696002)(7736002)(2351001)(305945005)(81156014)(54906003)(31686004)(36756003)(14444005)(446003)(11346002)(97736004)(316002)(478600001)(486006)(229853002)(2616005)(53936002)(25786009)(5660300002)(76176011)(71200400001)(4326008)(6486002)(186003)(5640700003)(102836004)(6306002)(52116002)(99286004)(71190400001)(26005)(6512007)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1143;H:CY4PR12MB1798.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: srnp0vnmFvZsFUwgcsU7fdcpO8HoFENFxk0s7uhhEb+wWqfE1aqjvBJi6YnfLtoUmUkz5ijWsfvEh8/paE71/7FWZd4ghJvnbECvKDlgMGgqhr5El36stqUSdylcMmOfCfOaygNa8cNo3MbqoHdjsWnS1GA3+egMrsSvbPRBN1SqGu2R8swZaanIjEDg2r5unIxMinPKCuoij01CnflLFq6swT/qc3C7o20mBETdf11s1ozxhRdjOto89rkX4q+DkYFlUFCkcw62WMlvDHZ4/lIoG7ew/rggZoGn3jRasB/JKqheGGZFEdky2+rXVUkV/+k4Che0YiqJLCrUh0+NNxBoiZwWsY8KAq/LFCnHKZiVeGpdl/n7RXTQ0WOmtpdcnN8/TEiInLZSzH/wvAVICrFSHHGIOFAzEfRzl2YhFOo=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <2DAB6562F9242843A0250CE2AA4A3FEE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f92f1a02-854e-454a-f6ce-08d6aee42936
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2019 16:33:48.8950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1143
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

I've tested this patch and it gets rid of a slew of these messages:

kernel: EDAC amd64: Error: F0 not found, device 0x1460 (broken BIOS?)
kernel: EDAC amd64: Error: Error probing instance: 0

So please add my:

Tested-by: Kim Phillips <kim.phillips@amd.com>

Thank you,

Kim

On 3/21/19 3:30 PM, Ghannam, Yazen wrote:
> Hi Boris,
>=20
> Any comments on this set?
>=20
> Thanks,
> Yazen
>=20
>> -----Original Message-----
>> From: linux-edac-owner@vger.kernel.org <linux-edac-owner@vger.kernel.org=
> On Behalf Of Ghannam, Yazen
>> Sent: Thursday, February 28, 2019 9:36 AM
>> To: linux-edac@vger.kernel.org
>> Cc: Ghannam, Yazen <Yazen.Ghannam@amd.com>; linux-kernel@vger.kernel.org=
; bp@alien8.de
>> Subject: [PATCH v3 1/6] EDAC/amd64: Add Family 17h Model 30h PCI IDs
>>
>> From: Yazen Ghannam <yazen.ghannam@amd.com>
>>
>> Add the new Family 17h Model 30h PCI IDs to the AMD64 EDAC module.
>>
>> This also fixes a probe failure that appeared when some other PCI IDs
>> for Family 17h Model 30h were added to the AMD NB code.
>>
>> Fixes: be3518a16ef2 (x86/amd_nb: Add PCI device IDs for family 17h, mode=
l 30h)
>> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
>> ---
>> Link:
>> https://lkml.kernel.org/r/20190226172532.12924-1-Yazen.Ghannam@amd.com
>>
>> v2->v3:
>> * No change.
>>
>> v1->v2:
>> * Write out "Family" and "Model" in commit message.
>> * Sort model checks in increasing order.
>>
>>  drivers/edac/amd64_edac.c | 13 +++++++++++++
>>  drivers/edac/amd64_edac.h |  3 +++
>>  2 files changed, 16 insertions(+)
>>
>> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
>> index 6ea98575a402..98e8da9d9f5b 100644
>> --- a/drivers/edac/amd64_edac.c
>> +++ b/drivers/edac/amd64_edac.c
>> @@ -2211,6 +2211,15 @@ static struct amd64_family_type family_types[] =
=3D {
>>  			.dbam_to_cs		=3D f17_base_addr_to_cs_size,
>>  		}
>>  	},
>> +	[F17_M30H_CPUS] =3D {
>> +		.ctl_name =3D "F17h_M30h",
>> +		.f0_id =3D PCI_DEVICE_ID_AMD_17H_M30H_DF_F0,
>> +		.f6_id =3D PCI_DEVICE_ID_AMD_17H_M30H_DF_F6,
>> +		.ops =3D {
>> +			.early_channel_count	=3D f17_early_channel_count,
>> +			.dbam_to_cs		=3D f17_base_addr_to_cs_size,
>> +		}
>> +	},
>>  };
>>
>>  /*
>> @@ -3203,6 +3212,10 @@ static struct amd64_family_type *per_family_init(=
struct amd64_pvt *pvt)
>>  			fam_type =3D &family_types[F17_M10H_CPUS];
>>  			pvt->ops =3D &family_types[F17_M10H_CPUS].ops;
>>  			break;
>> +		} else if (pvt->model >=3D 0x30 && pvt->model <=3D 0x3f) {
>> +			fam_type =3D &family_types[F17_M30H_CPUS];
>> +			pvt->ops =3D &family_types[F17_M30H_CPUS].ops;
>> +			break;
>>  		}
>>  		/* fall through */
>>  	case 0x18:
>> diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
>> index 4242f8e39c18..de8dbb0b42b5 100644
>> --- a/drivers/edac/amd64_edac.h
>> +++ b/drivers/edac/amd64_edac.h
>> @@ -117,6 +117,8 @@
>>  #define PCI_DEVICE_ID_AMD_17H_DF_F6	0x1466
>>  #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F0 0x15e8
>>  #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F6 0x15ee
>> +#define PCI_DEVICE_ID_AMD_17H_M30H_DF_F0 0x1490
>> +#define PCI_DEVICE_ID_AMD_17H_M30H_DF_F6 0x1496
>>
>>  /*
>>   * Function 1 - Address Map
>> @@ -284,6 +286,7 @@ enum amd_families {
>>  	F16_M30H_CPUS,
>>  	F17_CPUS,
>>  	F17_M10H_CPUS,
>> +	F17_M30H_CPUS,
>>  	NUM_FAMILIES,
>>  };
>>
>> --
>> 2.17.1
>=20
>=20
