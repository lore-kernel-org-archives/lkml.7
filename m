Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA497C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D83C214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="j+01JyJQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731583AbfB1MOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 07:14:23 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:59687 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbfB1MOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 07:14:23 -0500
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c77d0970000>; Thu, 28 Feb 2019 20:14:19 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Thu, 28 Feb 2019 04:14:19 -0800
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Thu, 28 Feb 2019 04:14:19 -0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 28 Feb
 2019 12:14:13 +0000
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (104.47.34.51) by
 HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Thu, 28 Feb 2019 12:14:13 +0000
Received: from MN2PR12MB3278.namprd12.prod.outlook.com (20.179.81.19) by
 MN2PR12MB3391.namprd12.prod.outlook.com (20.178.240.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.15; Thu, 28 Feb 2019 12:14:10 +0000
Received: from MN2PR12MB3278.namprd12.prod.outlook.com
 ([fe80::4575:131d:fefc:68b7]) by MN2PR12MB3278.namprd12.prod.outlook.com
 ([fe80::4575:131d:fefc:68b7%5]) with mapi id 15.20.1643.022; Thu, 28 Feb 2019
 12:14:10 +0000
From:   Sachin Nikam <Snikam@nvidia.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ketan Patil <ketanp@nvidia.com>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Bharat Nihalani <bnihalani@nvidia.com>,
        Bo Yan <byan@nvidia.com>,
        Sai Gurrappadi <sgurrappadi@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Timo Alho <talho@nvidia.com>
Subject: RE: [PATCH] sched/cputime: Remove unnecessary assignment statement
Thread-Topic: [PATCH] sched/cputime: Remove unnecessary assignment statement
Thread-Index: AQHUzmOtDC9uXU9Tqky0/ES4HinMkqXzcrQAgAGESICAAAF9gIAAKA3Q
Date:   Thu, 28 Feb 2019 12:14:09 +0000
Message-ID: <MN2PR12MB3278E52D04119DC55597A293BB750@MN2PR12MB3278.namprd12.prod.outlook.com>
References: <1551248002-27303-1-git-send-email-ketanp@nvidia.com>
 <20190227103230.GM32494@hirez.programming.kicks-ass.net>
 <9bce6378-2221-f358-dc97-f15ee7ab546b@nvidia.com>
 <20190228094733.GY32494@hirez.programming.kicks-ass.net>
In-Reply-To: <20190228094733.GY32494@hirez.programming.kicks-ass.net>
Accept-Language: en-IN, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=SNIKAM@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2019-02-28T12:13:23.9493548Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic;
 Sensitivity=Unrestricted
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Snikam@nvidia.com; 
x-originating-ip: [115.114.90.35]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b16f007f-4c96-42ff-87cc-08d69d763e93
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MN2PR12MB3391;
x-ms-traffictypediagnostic: MN2PR12MB3391:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;MN2PR12MB3391;23:4phUbNF4TdJzwOR6AxosFo9CP4HOsfOeJh5i9lGi4?=
 =?us-ascii?Q?n6PjXRJCP9JjkvZdfiMrzOUPJAU1YG5RQ+0FqQR13lea1sn/XDsv1Ckt6tLI?=
 =?us-ascii?Q?h5kgEU67w2427oLGvhhecNoQDHh5oC4/XooMo/dVJwk/yRV91fbfiTFAHDFp?=
 =?us-ascii?Q?4gBeOmSGTzOo9OBWNFvYBt0VXPKUjLcdYDgMsxMNdy1d7KR4axYriL8SzkjY?=
 =?us-ascii?Q?pgVWBazzL4yvyDbmYxkEJYNAZxuTS45t9G5W3CH0ZRlVTYpqWeT4S8QzWXTa?=
 =?us-ascii?Q?FjT93Tq0efIQCwa7LqyJqcDidLEg4uP2DCy1b/NpFDYqEVFa7N6p9ICWuLck?=
 =?us-ascii?Q?W8nQNTrNniXjFIlz7NOMXWaHTW1hLTa2tg+ljg8OlYQc6mmPqm5ok2ecd0Sy?=
 =?us-ascii?Q?JPBDrAFc7saEgL/L364VvJKShDP/qUmhS2Wm9IhITRUMwrKwRq22+eylubKK?=
 =?us-ascii?Q?as5TDJ9P0KH1anfTQ8nJ06qAJDTe1EobCGcfHfpHqQ6UCzCPrlnLa22szqZh?=
 =?us-ascii?Q?bXJLAWAdQked9zk4o19eRcSHmgY2ieSajI0/dDS2bl3Dm6+pH9p2UYJoqfxU?=
 =?us-ascii?Q?fFTzvjlFD5h4uMMKmvMg0u6Vah4jKxOgT7bbmt4VDvj/RVRS8+G04ihPrTzG?=
 =?us-ascii?Q?ozrrUBxkY5p94JZxab7oX/UfRruCQoIkmDnefP3he0B76A1wHoF3CcnDhXbu?=
 =?us-ascii?Q?R5p34ZKThr3MNZLfwbBwPo3cJb2oQynpmqHgc8LUA8F6O1kwZeP3yqG/egP2?=
 =?us-ascii?Q?36o4tj7K3AHAyqtmIqoa8peZ7ODr8sH3hqwh8FJG64I0tDey58LfRylr0cwH?=
 =?us-ascii?Q?qCuSHNfaazhS2YHE8/VDG2I+3H+3V3IVtQs66ZXma7WDtpcHkS/vjvJEzXLI?=
 =?us-ascii?Q?6bTfdOHcU9MEyFz9DX/7AxBAwuos+muRniP/m1YWZJtCaAY4t7HDChFAeXcH?=
 =?us-ascii?Q?FvS/EPRkKdvy+DwEqt8yIMcN6JwFJCfBf5mHerWnv0PyQ+xBw6ECqD+jXV9h?=
 =?us-ascii?Q?W3CcevHSLDQaEpzfUVn/VYNM7530d+nOAuKALvOYw71htlI9LzKUxW+3Q+OR?=
 =?us-ascii?Q?fqch2Pj/tr6lgNALmdKKcH+61L8t59PERFPjj9dwuFhisbXmzgN4XYv4FKJ3?=
 =?us-ascii?Q?q/sfwaBnf9tQWkLCtxbwV9qB4tzyhJbUFuwbk65TmDQMgeBt+q+xHZcwhcvo?=
 =?us-ascii?Q?a3wOK/iez7i0TQuC/46XZWeK3OwqRZMsD2S56C1nsdSzQ8hhWlQka+zU7pW8?=
 =?us-ascii?Q?x1iObxbvX1l8fEOZh2xXWhKeJnOZRvPl6VZ/0+LYMfEjJLs2WFI2U3iVN/iH?=
 =?us-ascii?Q?c5t28S1aSIEFoDmpp5LOQZ9qGlQwgaLM7MifiZPZbmStzFtxK/cT1h83Y8U3?=
 =?us-ascii?Q?HsSI4t7DoXRG9vQPUPG0sQNXroIL7swq3gyo6xMtb+LqsgZ?=
x-microsoft-antispam-prvs: <MN2PR12MB3391F9CB840081B4C106BC47BB750@MN2PR12MB3391.namprd12.prod.outlook.com>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(136003)(366004)(376002)(199004)(13464003)(189003)(316002)(66066001)(4326008)(7736002)(8676002)(81166006)(81156014)(486006)(9686003)(5660300002)(6436002)(55016002)(476003)(25786009)(97736004)(6246003)(72206003)(93886005)(8936002)(107886003)(256004)(14444005)(14454004)(74316002)(71190400001)(71200400001)(478600001)(305945005)(102836004)(76176011)(6116002)(55236004)(3846002)(7696005)(53936002)(99286004)(53546011)(6506007)(106356001)(86362001)(110136005)(105586002)(229853002)(33656002)(11346002)(80792005)(446003)(6636002)(54906003)(52536013)(26005)(186003)(68736007)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3391;H:MN2PR12MB3278.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: o1rsCYuRSRlpqDwoDdAqADyHaDjuHSGwfFFepfy4ZzaTYQ+XtqlRvvc8JZhyHwIToBG7sbE/RhEQIhY5Ov2DZE8jSVUYXqbAqBBAScSxq7V4cif3dc+k+gmkrOWo/cOoKWOeqzWz+4YEggKsYwM4GHBKsSiExqnE+atsfLBBfedYhExtlRvqKlMOZKjbYRPBuXyFhqJ/YyjZRYwJL/41jRQUhWKqEKsYrLNFI8lfrthreizC+uJO8mE0m2wHcNufXwwLEaVsKYijvepikuV98Q9cYZyGJbluxvKxwa/hf8PusVHfU1ryaX0wkNQv4yON5ZxYZZGu9DwRk+R/UTJUpq0My/U2H1ffAVpUZBQvdnlDaoHsK87llF5oRKPkBvosTFvwZ4JCfCm4u1KrABodfxHOYD8gHNiIuJX8XcieIZQ=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b16f007f-4c96-42ff-87cc-08d69d763e93
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 12:14:09.9670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3391
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1551356059; bh=zHvjQJXLhojElNJoSyNwDv9yrVxm3WMS6tVZqx3l7qQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
         Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:msip_labels:authentication-results:
         x-originating-ip:x-ms-publictraffictype:
         x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
         x-ms-traffictypediagnostic:x-microsoft-exchange-diagnostics:
         x-microsoft-antispam-prvs:x-forefront-prvs:
         x-forefront-antispam-report:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam-message-info:
         MIME-Version:X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=j+01JyJQK1DUvkLBtnNtYwiCA3WFFMBdEQqNKTjTC/mTjx1xb+KhC38CIKD66Zr0s
         Hf5ImWj6Ulx+6Ss4yay2hrejv3CM1prLVzAt4REk2WwzklQkSuV2C7MrOV72kokN6u
         ypFTYwuM+gWPhYM4cvzcf6l8iy1DGHpfzHYQyorUTUVzdNGk54FgP3x+g39M/3utie
         0UkpxTHrnXJfcU5w1tTNvtLB/clve6k4HkiPFHjFYI4ilSI679Mh5c2YFjDs+5jQBP
         AMRm/t/s0VgPatoh0nnCBH5hi5fm8B1m8FfenthExC+21UJoa9e87+D3CferIXdMMx
         TOmtX4L+8T4yA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ketan,
What is the Coverity Impact Level for this defect?
If it is Low then we can whitelist this defect and change.

Peter,
This isn't a security fix.
However, I see this is kind of code cleanup.

-----Original Message-----
From: Peter Zijlstra <peterz@infradead.org>=20
Sent: Thursday, February 28, 2019 3:18 PM
To: Ketan Patil <ketanp@nvidia.com>
Cc: mingo@redhat.com; linux-kernel@vger.kernel.org; linux-tegra@vger.kernel=
.org; Sachin Nikam <Snikam@nvidia.com>; Bharat Nihalani <bnihalani@nvidia.c=
om>; Bo Yan <byan@nvidia.com>; Sai Gurrappadi <sgurrappadi@nvidia.com>; Thi=
erry Reding <treding@nvidia.com>; Timo Alho <talho@nvidia.com>
Subject: Re: [PATCH] sched/cputime: Remove unnecessary assignment statement


A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

On Thu, Feb 28, 2019 at 03:12:13PM +0530, Ketan Patil wrote:
> The coverity tool has detected this issue as an unused value, since=20
> the code assigns the value to utime variable and then after the jump,=20
> the value of utime again gets updated, hence the previous value is not=20
> at all useful and this patch removes that first assignment.

Not a security issue then; just tell coverity to shut up.
