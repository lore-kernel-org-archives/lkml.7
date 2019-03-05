Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B46C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 22:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66FD520661
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 22:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="bdSIvSwH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbfCEWVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 17:21:43 -0500
Received: from mail-eopbgr40053.outbound.protection.outlook.com ([40.107.4.53]:24645
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726210AbfCEWVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 17:21:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqzy6r6QFMDaL6qdlDaGpiZxp26Kqvf5uJ/UECu/fYw=;
 b=bdSIvSwHq9zVgKg8uZCyyHE6j4VlX2p4d2AfOxdAoi1g2L8BlJXhLyGtCxjqhEgdcKwoagoLc20Fxnt4n6ISNY6NaMl0NJf49rbeLQTcEvhH9yBG2Ncxak/a651pOcy2DpMhdZ/PgCVxoWQH+sY6ZCN5Xt1nuk0JkjFjHy+/Gm4=
Received: from DB8PR05MB5898.eurprd05.prod.outlook.com (20.179.9.32) by
 DB8PR05MB6076.eurprd05.prod.outlook.com (20.179.11.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.18; Tue, 5 Mar 2019 22:21:39 +0000
Received: from DB8PR05MB5898.eurprd05.prod.outlook.com
 ([fe80::28ed:92cd:4075:b660]) by DB8PR05MB5898.eurprd05.prod.outlook.com
 ([fe80::28ed:92cd:4075:b660%2]) with mapi id 15.20.1665.020; Tue, 5 Mar 2019
 22:21:39 +0000
From:   Saeed Mahameed <saeedm@mellanox.com>
To:     Roi Dayan <roid@mellanox.com>, "leon@kernel.org" <leon@kernel.org>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        Eli Britstein <elibr@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] net/mlx5e: Remove redundant assignment
Thread-Topic: [PATCH][next] net/mlx5e: Remove redundant assignment
Thread-Index: AQHU0S+tjWF8L6Ijf0eajSu7+CzZyqX6BweAgAD9E4CAAp0gAA==
Date:   Tue, 5 Mar 2019 22:21:39 +0000
Message-ID: <176546c027a13f39c0dd8d5915b2d16b98637782.camel@mellanox.com>
References: <20190302193933.GA13467@embeddedor.com>
         <da1f1300-20f4-2929-078b-71ac1772a933@mellanox.com>
         <20190304062645.GZ15253@mtr-leonro.mtl.com>
In-Reply-To: <20190304062645.GZ15253@mtr-leonro.mtl.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=saeedm@mellanox.com; 
x-originating-ip: [209.116.155.178]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 32406c20-014e-4261-8f78-08d6a1b8f059
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB8PR05MB6076;
x-ms-traffictypediagnostic: DB8PR05MB6076:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtEQjhQUjA1TUI2MDc2OzIzOjFGRSsyendxZmR0OTlJQ2NxR0NlRy9pSlF4?=
 =?utf-8?B?MXlqNlhyeHNaM1hSVjNzeGRVbDhIMmlUc3c2VDhMbmFENHJWNldneHl6VU9x?=
 =?utf-8?B?aTBYck9jR0VzSCtlbFNCaEQ4ZUp3YkY0c1RHR3Z2eTFHNGJMTnk0cmk2MktK?=
 =?utf-8?B?Y2RCWndKbFd4MjA4NS9vR1VPdzNJZ1pxbDVPcUU1d3F5NWdRWmI5Z1JuTVhP?=
 =?utf-8?B?ZkFIdmoyeFVTREdnbmRKNDJ4a2FTWWJ5aHNPVTdGelhZQVo4bHNETDZ2TTUy?=
 =?utf-8?B?aUorSWlpTEVYNGhXZWZiRWU0eFVMOUt6M3RCZFlUcjFJWDFsdDN4VTJ4R2sx?=
 =?utf-8?B?aFRjTkF5UXJYWWtYSWx3c3NPVXE1c0kzVmk5NWQzUmRZd29HbklEdExzdzJB?=
 =?utf-8?B?T3NUM21Gd1JrWnF1Y1dsdXNxMVpjUGZzN1pPaVhvdlVGd1BkM3cwYm1HNExT?=
 =?utf-8?B?MGFURjZrSlpyazRKcmJ5M1Fwb2dPUG1qejNXMVVMYXBzTnQrMkFmQnlvT0gz?=
 =?utf-8?B?UmQvbndGMG84QjNLMlQyeDlIUURRYWpaZW1wV0tZd1U0RWNjVks4R2NUb3NW?=
 =?utf-8?B?SWdoT0IyRTlsdlVzZmM3b2JLdWxXZ3cydlVFOFB6eEQ1N29xemRsYmovc2Fx?=
 =?utf-8?B?MEp1VUtwUFhDWHVWN1JLajFvU3pjMjlPWFdiYm1jTlIxcloyRVVhRUVTSjcv?=
 =?utf-8?B?VG5jWHNnSWlZa3BmRVE5OERiNnVBZW9sbjBxa09KUUpRUmZheWVlTVJuTGZS?=
 =?utf-8?B?d0QyNzYyM3FvWnJRb0UvYUhFKzg2OCsyQVhseisvQk1oZnRKbVpadFB1Tnl4?=
 =?utf-8?B?cmNBMTl3U1d4RHF2ZG94aFhlbFNZT0daNXQxU0Z5VXRlM3VjSlJSTTdlZFlM?=
 =?utf-8?B?dzhZVTNMWEdnQVdpTlFRMW0yUk5OaEtxSlpIdnZ3QUhrQ2VLMHNsQm5CUGtl?=
 =?utf-8?B?ZGp5cjQvSGlBayt4Ym53U1FPNXo5c2F4emF3YVg1cEYzeUpkSWhjK2ZrM1RW?=
 =?utf-8?B?d3NEaU5HZDVhOU85WjhjQjhqaXpaR0hRZEpLd3E4YlQ1eFZOMXpEbHQ2NVRE?=
 =?utf-8?B?S2MwT1RIeG9HQ3hoTW5TY0FiU2MvTHk0MFlnNE9OTXRpdzhPRWp0eGc2REZo?=
 =?utf-8?B?SE1wMTMyN0Z0aVY2TURoYjV4YzdIUElpZjhtSUY4Wkh6cXN2WFdwQjlkcSsr?=
 =?utf-8?B?RTZvNXlnKy9MZmc3SEo0dkdBeDdrbEFsZ05iUlJXWVBRWFlvSnREWDU4QS8w?=
 =?utf-8?B?TVJETllJKzZyaHcrS29Ca25VMHhhbEdETmxxcUhEajRlQmZVNE9pZ1poN0ll?=
 =?utf-8?B?S1RKZHh6UXhQalc1a0E5dGEzTXZ4ZzduT1JvbnBIak1NeXB1MjExMFdHeGRz?=
 =?utf-8?B?QzB3ZVdmRHE3dUZjNERYRGdZRkUvQy9NdkVPLy85Vm45bUR3c2M1WHR2dWlz?=
 =?utf-8?B?QU9GN0QwZW1mNG9BSUpaeTFMME9PdzZ2eVVyN3Q1ZFhIUCs4TUd5R1RFQk81?=
 =?utf-8?B?K1h3aGZFcWlNSjVVUTVGZWpoVUxTT1RMNiszYm1ZdmY0RFVHaTNuNEphMXA4?=
 =?utf-8?B?ZWZJcWhxTGNOOXptTHpEWFdhVkhXL1ZRSTBZSHdwZlR1TWJhcUc5NXlqSDdi?=
 =?utf-8?B?amlxRzZ1dzRUVHdnYnFkMUUyWW1TUG00Q25PWUZiRFFRSUVCQVI5VGU4MlNG?=
 =?utf-8?B?bWlKZ3UyYTBHRVBPb1A3R0t3aFVGRHFnb0VrbkF4QitYRDlCbDBSVkVwTElW?=
 =?utf-8?B?eHhaa294NGxzSHcyVFJqdz09?=
x-microsoft-antispam-prvs: <DB8PR05MB607668E7F3D14C182C7004F2BE720@DB8PR05MB6076.eurprd05.prod.outlook.com>
x-forefront-prvs: 0967749BC1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(396003)(376002)(346002)(199004)(189003)(478600001)(102836004)(14454004)(68736007)(105586002)(106356001)(4326008)(6486002)(6512007)(66066001)(186003)(6506007)(26005)(4744005)(118296001)(8936002)(5660300002)(71190400001)(97736004)(305945005)(53546011)(7736002)(71200400001)(486006)(36756003)(54906003)(2501003)(316002)(86362001)(110136005)(6116002)(3846002)(11346002)(446003)(229853002)(76176011)(81156014)(2906002)(6246003)(25786009)(58126008)(476003)(2616005)(256004)(6436002)(14444005)(99286004)(53936002)(8676002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR05MB6076;H:DB8PR05MB5898.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LlIijBUL9/xV7BeZ/MdXJgEUABPs2I5g70PLOFjMpLNpYC7hRI+ZX2dvd2ER+DeE0hBNM+tjp/KpFtCSetu+7LmpIX7spgbExV2eQpWe5SNyEmPSTkrYwo2ZJt5CV6YJoAiDZygGiL1dNwHtf4UO9J047uiMuSG5Jt3npKuIlxd0pp1cZnf07b0xU6mVIbzKdf2gzyHOb/SmPELJQUjBDlISsbPzuxs1foqTjxG5Ty22fQXqlaNR7hL6UvY/PS3CV7dpSgi4kqrx4xtCYo/JXplkS3WLqM7waXCH86y7YP5lXWYYvdDTl4qoy9rouSu6j9+PfY+dEc9rRPRh9C2qHvd4gNhfJ3vByROlBtPwaFK0SGjzPCcES2Ni8dOUwukaL7c+xTt/VdUPHI1DQwO6ERUiv35BEOwIhJIHikOakR8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D29EA8F177736B419C08F6EDF67AFBAC@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32406c20-014e-4261-8f78-08d6a1b8f059
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2019 22:21:39.6648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR05MB6076
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE5LTAzLTA0IGF0IDA4OjI2ICswMjAwLCBMZW9uIFJvbWFub3Zza3kgd3JvdGU6
DQo+IE9uIFN1biwgTWFyIDAzLCAyMDE5IGF0IDAzOjIwOjU3UE0gKzAwMDAsIFJvaSBEYXlhbiB3
cm90ZToNCj4gPiANCj4gPiBPbiAwMi8wMy8yMDE5IDIxOjM5LCBHdXN0YXZvIEEuIFIuIFNpbHZh
IHdyb3RlOg0KPiA+ID4gUmVtb3ZlIHJlZHVuZGFudCBhc3NpZ25tZW50IHRvIHR1bl9lbnRyb3B5
LT5lbmFibGVkLg0KPiA+ID4gDQo+ID4gPiBBZGRlc3Nlcy1Db3Zlcml0eS1JRDogMTQ3NzMyOCAo
IlVudXNlZCB2YWx1ZSIpDQo+ID4gPiBGaXhlczogOTc0MTdmNjE4MmY4ICgibmV0L21seDVlOiBG
aXggR1JFIGtleSBieSBjb250cm9sbGluZyBwb3J0DQo+ID4gPiB0dW5uZWwgZW50cm9weSBjYWxj
dWxhdGlvbiIpDQo+ID4gDQo+ID4gdGhlIGNvbW1pdCBkb2Vzbid0IGZpeCBhbnkgcmVhbCBpc3N1
ZSBidXQgaXMgbW9yZSBvZiBhIGNsZWFudXAuDQo+ID4gc28gSSdtIG5vdCBzdXJlIGlmIGZpeGVz
IGxpbmUgaXMgcmVsZXZhbnQgb3Igbm90Lg0KPiA+IGJlc2lkZSB0aGF0IGxvb2tzIG9rLg0KPiAN
Cj4gSXQgZG9lc24ndCBtYXR0ZXIgaWYgaXQgaXMgcmVhbCBpc3N1ZSBvciBub3QsIHRoZSBjb2Rl
IGlzIHdyb25nIGFuZA0KPiBzaG91bGQgYmUgZml4ZWQuIFRoaXMgYWxvbmUgaXMgZW5vdWdoIHRv
IHNlZSB0aGUgRml4ZXMgbGluZS4NCj4gDQo+IFRoYW5rcywNCj4gQWNrZWQtYnk6IExlb24gUm9t
YW5vdnNreSA8bGVvbnJvQG1lbGxhbm94LmNvbT4NCg0KQWNrZWQtYnk6IFNhZWVkIE1haGFtZWVk
IDxzYWVlZG1AbWVsbGFub3guY29tPg0KRGF2ZSwgRG8geW91IHRoaW5rIHN1Y2ggcGF0Y2ggc2hv
dWxkIGdvIHRvIG5ldCwgb3IgZG8geW91IHdhbnQgbWUgdG8NCnNlbmQgaXQgaW4gbXkgbmV4dCBw
dWxsIHJlcXVlc3QgdG8gbmV0LW5leHQsIG9uY2UgaXQgaXMgb3BlbiBvZiBjb3Vyc2UNCj8NCg==
