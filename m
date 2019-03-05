Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD9DC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 18:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5361420645
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 18:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="XH1s4Y3a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730851AbfCESIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 13:08:14 -0500
Received: from mail-eopbgr740107.outbound.protection.outlook.com ([40.107.74.107]:13632
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726118AbfCESIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 13:08:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2zchODyp2Qb8gO8zCwPYCA/MVi+P3RMZvMpaAojBTU=;
 b=XH1s4Y3aPr0xNVkSD1TXlAE01wWfDYsiOv/PevberXt/D+B+f7OH/tWmnysYDGLyvXa9RDlO5XiQ+yjdmPRnrLdSaJv1QSvOFW1C1scpnYNrmwkyTWIVejQb52rAlVg2G24EG5/vnmi/EdYW6ScXxIUtcsXpe/nCcq5hXvsdijA=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1184.namprd22.prod.outlook.com (10.174.171.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.16; Tue, 5 Mar 2019 18:08:09 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b8d4:8f0d:d6d1:4018]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b8d4:8f0d:d6d1:4018%3]) with mapi id 15.20.1665.020; Tue, 5 Mar 2019
 18:08:09 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Main MIPS pull request for 5.1
Thread-Topic: [GIT PULL] Main MIPS pull request for 5.1
Thread-Index: AQHU0uqNNgYF265XUkeWrFWbGS7EQKX9Vu+A
Date:   Tue, 5 Mar 2019 18:08:09 +0000
Message-ID: <20190305180807.g4smnioautln3ww6@pburton-laptop>
References: <20190305002951.jdrcgn5jf5xoa5rr@pburton-laptop>
In-Reply-To: <20190305002951.jdrcgn5jf5xoa5rr@pburton-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR05CA0037.namprd05.prod.outlook.com
 (2603:10b6:a03:74::14) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bfd8388a-4bcb-4f0c-cd7f-08d6a19585dc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(49563074)(7193020);SRVR:MWHPR2201MB1184;
x-ms-traffictypediagnostic: MWHPR2201MB1184:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;MWHPR2201MB1184;23:OKP62ISdZgbspfg1hIzQ+oxLE6rZRprf+nC7maX?=
 =?us-ascii?Q?f3pD5plvSBKLyC5U7yx6Y32ycYvR0NVctnc7G1iF4/KTZL5ucBZrQgAUhwwH?=
 =?us-ascii?Q?+whR5wq5qCjzs38RXPCWq/4ecW5EicKz4gkJMZpKWLTlIXofJc02JmkjM1tt?=
 =?us-ascii?Q?DGhOvpt8lIUU58Esu6eHMlyel2MeS5ppkIfD5a9sqjAwmr8FvhOMyRbDyVgL?=
 =?us-ascii?Q?vLGVd4Ix9VXkDafMmWdjIukTaD4uyXSF8T18Fen3v7jaGLo87Pu+Dzj9Y7tR?=
 =?us-ascii?Q?dyaKn98ro4vkOe6/+3PJ7BpXDFIeMcq/PXYCoK6w7wZXBbio7rLWBZ9+lPAz?=
 =?us-ascii?Q?5qtTUP4UT6pxVNCQ0ueuwoREiI0IQV3s/b3dzEutIHsX9ra/9lEXp6gCiyCF?=
 =?us-ascii?Q?eoEROARqvBqO2uuedAUJKzvMYcWbyg0dIQGTGJqdVBLvN9Fi0Rfr1AZOy1bx?=
 =?us-ascii?Q?eKKdjXkRlj/ElvALq8aDwe6OQjxmnHNdQ5Ar5OpLKr5o3mH1xxenLvyjm9kY?=
 =?us-ascii?Q?NsGyHAMCF6zp7DIEMGTAut4FXW+M0DRQWkcXGtVfZB5l4+LtOTFNK8E/1Z7y?=
 =?us-ascii?Q?t3A1qEpe+CY7OidSmkTTjm96TTx/eJQS7QHHBc/tNkcsFpAQxYq2ZqYxslX3?=
 =?us-ascii?Q?w24LSwjBxoDLI52r64UTmJBbcPn3qQaMoaSuBZgYkKristzbHgaJQTX8iVoz?=
 =?us-ascii?Q?X3AmOSyJNWPp6LPmitwkfLj6xYZkwKFCTNE8PqB5XMz49pv2KdFnSPSIb+qO?=
 =?us-ascii?Q?bQ4eF5XphCl5il8swV+SajWb40i3erPjfYB4GTcHxUb5xoUU2lW52GSubplL?=
 =?us-ascii?Q?/IKTXxbo+ireohQ7734hrCXiRz7fV7nPB/h3SNKYjPmw6GVU+guy5IlzmDuE?=
 =?us-ascii?Q?DHi4nzNzufsac4Ii6FF7Oot5AReERVNTDc3NTfUEgeQQGQjUK7gNSdNgGzsk?=
 =?us-ascii?Q?6Q+B3sxe2g+Q52y7cV5GN4Ha8tiPppK2GpHVuE+qJnXQqeKVeeAQ4KNpZrrF?=
 =?us-ascii?Q?PkEFI1r4UApdifkx1L5AzMSJM5LHsZdp+qdQXN8Dqr3nplZLORmAKkJQm0bz?=
 =?us-ascii?Q?FijjnAeH0vDzd/QQrJfI7OFSoUcP6Wzs9E0ZWau8Uuw5mKobceqpWlzPdMWq?=
 =?us-ascii?Q?3Po0XMBi6NGmYa/JvK0tlfQRxqYz3pqzk/2wyviVdvVtDc0OiiTV8iHgE6z/?=
 =?us-ascii?Q?xh9a+hOsd+LiyG9/XSEkrK/WTSmyDYoW4REc2lysdE22rmcYGvWSypWLneXL?=
 =?us-ascii?Q?Eph9NPljevLouVFigroV/6JHTkBaNQ+p77dsMgSAX3fNtM9Z8hXihIYMvL/h?=
 =?us-ascii?Q?9dN4TEB8M21CXMtpHYlMgNTg9Us9vz6boiI5TccpUupHP?=
x-microsoft-antispam-prvs: <MWHPR2201MB11849F99ADCA7DC32DE55DD1C1720@MWHPR2201MB1184.namprd22.prod.outlook.com>
x-forefront-prvs: 0967749BC1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(346002)(39850400004)(396003)(366004)(136003)(199004)(189003)(99936001)(99286004)(305945005)(316002)(7736002)(54906003)(14444005)(58126008)(256004)(6916009)(106356001)(105586002)(5660300002)(8936002)(4744005)(81166006)(81156014)(8676002)(1076003)(2906002)(68736007)(71190400001)(71200400001)(53936002)(4326008)(229853002)(6512007)(9686003)(446003)(66066001)(26005)(25786009)(6486002)(6436002)(186003)(102836004)(97736004)(42882007)(6116002)(3846002)(33716001)(478600001)(44832011)(486006)(76176011)(6506007)(386003)(14454004)(11346002)(476003)(6246003)(52116002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1184;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mbGVzwLnly64z+2c0YUBf/Aw1EC9VdQWW76sfV1jDzzVkvsFoCJWKv1FUxE+B4bLV+y7uAl2fLB8kBvWO54GTjRmGN4CD+kY6mgRsR6wNQnwWN+EP2IXPJ/I7fUz5fp1Nur6gLGsCHmlJxGCH3jKpqERuIo1/Qz26tKVbrBzoYUYIOFjMTMXGmsAMub5y0ieoFzxI2vpOVit6S8pUu0UOG90VEQtRX6SveENe8I9ZyqZ4rQQg9SkECTNSqfQ7hBdfZwyM3O+7VxHWBUJlv/pfHoH9pbpMJLwL+8U+C0IigX8XnndJhtbnIA0r4yLb4jjyu8b1bqLN5YEGYBL9mRgcGnzjzJ49J5BsQh2/SoIpddH7UT+8SWV2NAo5kNdBH73ahSAizw/fMsADRPuA5xToBtlvHmcAbCoPubaYZFrKbI=
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dd2rfn5hi4kxu2ua"
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfd8388a-4bcb-4f0c-cd7f-08d6a19585dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2019 18:08:09.2237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1184
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--dd2rfn5hi4kxu2ua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Tue, Mar 05, 2019 at 12:29:53AM +0000, Paul Burton wrote:
> The following changes since commit 1c7fc5cbc33980acd13d668f1c8f0313d6ae9f=
d8:
>=20
>   Linux 5.0-rc2 (2019-01-14 10:41:12 +1200)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git tags/mips_=
5.1
>=20
> for you to fetch changes up to aeb669d41ffabb91b1542f1f802cb12a989fced0:
>=20
>   MIPS: lantiq: Remove separate GPHY Firmware loader (2019-02-25 14:17:10=
 -0800)

D'oh, I forgot to mention that you'll see a few conflicts when merging
due to fixes that went into v5.0. The correct resolutions are:

- Delete arch/mips/ath79/dev-spi.h as done in mips_5.1.

- Keep the mips_5.1 version of arch/mips/include/asm/pgtable.h (the
  version using cmpxchg).

- Keep both hunks of code added to arch/mips/include/asm/barrier.h.

Thanks,
    Paul

--dd2rfn5hi4kxu2ua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRgLjeFAZEXQzy86/s+p5+stXUA3QUCXH67BwAKCRA+p5+stXUA
3S1vAQD5UfPToxZFOsa8R4vwIeBDJFRkwbh7HfuIfe6bu8fxUQEAjT2JBR3NDybC
3Q6TEMoqnIhCS5w+3bZY6NNMPuRedg0=
=x5Vg
-----END PGP SIGNATURE-----

--dd2rfn5hi4kxu2ua--
