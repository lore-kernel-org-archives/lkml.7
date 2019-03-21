Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A01AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C71DF2183E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fiJdTH6b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbfCUUaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 16:30:06 -0400
Received: from mail-eopbgr780057.outbound.protection.outlook.com ([40.107.78.57]:15520
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728775AbfCUUaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 16:30:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxFJUOHmJQ4lLMm7kdCmgC4XtGwLrW1Byn/sos6h2bo=;
 b=fiJdTH6b+17ZLde9n1jhVp/0EOYOJ6Ufe6Hosyg9V6RBDsQqSbr7VLXqRzpFtTOKA1iGIIDIVqQFHf3Nqewq9i3/FqwcjEBeWolWqw23y4OMzlGOk9fe4LhVSRHV30k9RuhrugiF0JeXv1aEROOSYoI0ztYNqF7o4hcrgFo5+Lw=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2799.namprd12.prod.outlook.com (52.135.107.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Thu, 21 Mar 2019 20:30:02 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2%5]) with mapi id 15.20.1730.013; Thu, 21 Mar 2019
 20:30:02 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: RE: [PATCH v3 1/6] EDAC/amd64: Add Family 17h Model 30h PCI IDs
Thread-Topic: [PATCH v3 1/6] EDAC/amd64: Add Family 17h Model 30h PCI IDs
Thread-Index: AQHUz3tUM9ZrTnXDwUK+nakLJj6Q4qYWqkZw
Date:   Thu, 21 Mar 2019 20:30:02 +0000
Message-ID: <SN6PR12MB2639CDDA70C504DFEF5EE7B8F8420@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <20190228153558.127292-1-Yazen.Ghannam@amd.com>
In-Reply-To: <20190228153558.127292-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [165.204.84.17]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d75c92e-1244-44f8-043a-08d6ae3bff11
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2799;
x-ms-traffictypediagnostic: SN6PR12MB2799:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR12MB2799F32AC50A4064122C440EF8420@SN6PR12MB2799.namprd12.prod.outlook.com>
x-forefront-prvs: 0983EAD6B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(376002)(39860400002)(346002)(199004)(189003)(13464003)(110136005)(6436002)(478600001)(105586002)(2501003)(966005)(14454004)(106356001)(6306002)(256004)(6246003)(72206003)(14444005)(97736004)(9686003)(55016002)(53936002)(25786009)(33656002)(4326008)(54906003)(6506007)(86362001)(229853002)(8936002)(316002)(3846002)(26005)(476003)(66066001)(53546011)(81156014)(8676002)(7736002)(81166006)(2906002)(102836004)(305945005)(99286004)(74316002)(446003)(5660300002)(71200400001)(486006)(186003)(71190400001)(68736007)(7696005)(6116002)(52536014)(76176011)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2799;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nXBzXC4exvGu+djJAWX7HQ2cifhklSSgybd4X1BU47oUmPIMktCrPGVdSmOmVibKr6tpKN+6489ZGn2isgN4OvU/NJRZSVXz64UgOC5rB0VwX+pGhzz3Pb28HfzZCWaHVNtFfaxsdpqdQvd3t6ZRhz5OAA9gX/XiH9SAk7auGKMHJFTEgV1aJRD4HZtDgxBtlp3og5FKCCa6VBjsjxSJzYSrw6MKn6tsOYswmkTlvY29Hme8OSaQvmmVW6tn8Dto55j6vhEvkK7xFFzQRRcbAGr6wNoRYwaITHrRq+3YjuBrT1Ag5bCRgSZeRCe2sXSc1XUi+z5jycl0NuxA6MkbVOlQvOdlJnijkMn2kK+GRcPsVcrqa/sVS7bsM77K0pIxrvrCNRSekIs7aW5lt4vPGeu4BQ0AcnyZhwORvk4nNLM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d75c92e-1244-44f8-043a-08d6ae3bff11
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2019 20:30:02.3581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2799
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

Any comments on this set?

Thanks,
Yazen

> -----Original Message-----
> From: linux-edac-owner@vger.kernel.org <linux-edac-owner@vger.kernel.org>=
 On Behalf Of Ghannam, Yazen
> Sent: Thursday, February 28, 2019 9:36 AM
> To: linux-edac@vger.kernel.org
> Cc: Ghannam, Yazen <Yazen.Ghannam@amd.com>; linux-kernel@vger.kernel.org;=
 bp@alien8.de
> Subject: [PATCH v3 1/6] EDAC/amd64: Add Family 17h Model 30h PCI IDs
>=20
> From: Yazen Ghannam <yazen.ghannam@amd.com>
>=20
> Add the new Family 17h Model 30h PCI IDs to the AMD64 EDAC module.
>=20
> This also fixes a probe failure that appeared when some other PCI IDs
> for Family 17h Model 30h were added to the AMD NB code.
>=20
> Fixes: be3518a16ef2 (x86/amd_nb: Add PCI device IDs for family 17h, model=
 30h)
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
> Link:
> https://lkml.kernel.org/r/20190226172532.12924-1-Yazen.Ghannam@amd.com
>=20
> v2->v3:
> * No change.
>=20
> v1->v2:
> * Write out "Family" and "Model" in commit message.
> * Sort model checks in increasing order.
>=20
>  drivers/edac/amd64_edac.c | 13 +++++++++++++
>  drivers/edac/amd64_edac.h |  3 +++
>  2 files changed, 16 insertions(+)
>=20
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 6ea98575a402..98e8da9d9f5b 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -2211,6 +2211,15 @@ static struct amd64_family_type family_types[] =3D=
 {
>  			.dbam_to_cs		=3D f17_base_addr_to_cs_size,
>  		}
>  	},
> +	[F17_M30H_CPUS] =3D {
> +		.ctl_name =3D "F17h_M30h",
> +		.f0_id =3D PCI_DEVICE_ID_AMD_17H_M30H_DF_F0,
> +		.f6_id =3D PCI_DEVICE_ID_AMD_17H_M30H_DF_F6,
> +		.ops =3D {
> +			.early_channel_count	=3D f17_early_channel_count,
> +			.dbam_to_cs		=3D f17_base_addr_to_cs_size,
> +		}
> +	},
>  };
>=20
>  /*
> @@ -3203,6 +3212,10 @@ static struct amd64_family_type *per_family_init(s=
truct amd64_pvt *pvt)
>  			fam_type =3D &family_types[F17_M10H_CPUS];
>  			pvt->ops =3D &family_types[F17_M10H_CPUS].ops;
>  			break;
> +		} else if (pvt->model >=3D 0x30 && pvt->model <=3D 0x3f) {
> +			fam_type =3D &family_types[F17_M30H_CPUS];
> +			pvt->ops =3D &family_types[F17_M30H_CPUS].ops;
> +			break;
>  		}
>  		/* fall through */
>  	case 0x18:
> diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
> index 4242f8e39c18..de8dbb0b42b5 100644
> --- a/drivers/edac/amd64_edac.h
> +++ b/drivers/edac/amd64_edac.h
> @@ -117,6 +117,8 @@
>  #define PCI_DEVICE_ID_AMD_17H_DF_F6	0x1466
>  #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F0 0x15e8
>  #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F6 0x15ee
> +#define PCI_DEVICE_ID_AMD_17H_M30H_DF_F0 0x1490
> +#define PCI_DEVICE_ID_AMD_17H_M30H_DF_F6 0x1496
>=20
>  /*
>   * Function 1 - Address Map
> @@ -284,6 +286,7 @@ enum amd_families {
>  	F16_M30H_CPUS,
>  	F17_CPUS,
>  	F17_M10H_CPUS,
> +	F17_M30H_CPUS,
>  	NUM_FAMILIES,
>  };
>=20
> --
> 2.17.1

