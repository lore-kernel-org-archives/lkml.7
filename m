Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB41C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBA4E2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="C58KFZQt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfC1OPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 10:15:13 -0400
Received: from mail-eopbgr740089.outbound.protection.outlook.com ([40.107.74.89]:5623
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725849AbfC1OPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 10:15:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZtCc/hiXX/wgAmhv9+NudPue0cLn90GZ+ojPQZPr7w=;
 b=C58KFZQtY+dbQIF67deWNr7WLb6XCT0jf302FEeddxA42MfdBX0m6TfuY1c0XbOstRggoxqjw1rpnIuhpF01GVsLuW38Ubyq5vW8Efyuyj38ZvHii61mSHQ/XD19IJl0DfTyNA7GI9MFXZF+iVIdrHQqsWncwSV744NpVVCKipc=
Received: from BYAPR05MB5048.namprd05.prod.outlook.com (20.177.230.218) by
 BYAPR05MB6024.namprd05.prod.outlook.com (20.178.53.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.13; Thu, 28 Mar 2019 14:15:02 +0000
Received: from BYAPR05MB5048.namprd05.prod.outlook.com
 ([fe80::8186:de6a:919f:34a5]) by BYAPR05MB5048.namprd05.prod.outlook.com
 ([fe80::8186:de6a:919f:34a5%6]) with mapi id 15.20.1771.006; Thu, 28 Mar 2019
 14:15:02 +0000
From:   Vishnu DASA <vdasa@vmware.com>
To:     Jorgen Hansen <jhansen@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
CC:     Pv-drivers <Pv-drivers@vmware.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [Pv-drivers] [PATCH] VMCI/VSOCK: Add maintainers for VMCI,
 AF_VSOCK and VMCI transport
Thread-Topic: [Pv-drivers] [PATCH] VMCI/VSOCK: Add maintainers for VMCI,
 AF_VSOCK and VMCI transport
Thread-Index: AQHU5XCii0jziUXo2kWN5iBj68ShCA==
Date:   Thu, 28 Mar 2019 14:15:02 +0000
Message-ID: <6ED46E4B-6F35-41B9-86FF-69986D19352F@vmware.com>
References: <1553179288-40893-1-git-send-email-jhansen@vmware.com>
In-Reply-To: <1553179288-40893-1-git-send-email-jhansen@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.10.8.190312
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vdasa@vmware.com; 
x-originating-ip: [2601:647:4a00:444d:5512:e0cc:3ff1:1698]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ef7fa66f-aace-4067-a7b7-08d6b387c506
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB6024;
x-ms-traffictypediagnostic: BYAPR05MB6024:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-microsoft-antispam-prvs: <BYAPR05MB6024A13865B408FFB4C10B8DCE590@BYAPR05MB6024.namprd05.prod.outlook.com>
x-forefront-prvs: 0990C54589
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(136003)(376002)(39860400002)(199004)(189003)(58126008)(305945005)(558084003)(86362001)(25786009)(71190400001)(54906003)(71200400001)(76176011)(106356001)(83716004)(6506007)(2906002)(53546011)(81156014)(7736002)(8936002)(105586002)(256004)(81166006)(14444005)(6116002)(8676002)(110136005)(68736007)(2501003)(186003)(229853002)(6246003)(11346002)(5660300002)(2201001)(6436002)(46003)(2616005)(97736004)(486006)(82746002)(99286004)(446003)(478600001)(6486002)(316002)(36756003)(6512007)(102836004)(14454004)(4326008)(53936002)(476003)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB6024;H:BYAPR05MB5048.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qE3hXXb/is70+eWoZNAA0o9EYNgBLF4ynqEQqrEAXQBsIYHRd0gNMzRC51ph9nxJGqQrGu23vkPzpxjsrJ6QZmcq8VJmz5ushxGTgs7U6+ZkGgqFEMwTYVoUiLfbbd1rqpJqjT7FNH176z4lIBcr1qzUHp99bOZOUzw3dOtV6tludo118N/aaunyMRqBIujdmjAYVb1MLPBI3smPa9RX4DhD8Nka36Z6rqxg7XNMFonGKG7qpUxqPIiNdBhQdmu0fNxqBKEoZNiBdavImzuxs66y26PxhBmkP4pZ7X6KB0zdodvr4rbtdzl4PeFZxMzhoFfmoF/m5Pku+6L36IMJ5EUrqVoW2tekrQjySPKI+xdfGJrzRssfywSi0L2g+dFmqmL2qilYx03zuwpZaq3phentsY941o3mtUrq0tqTLvI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A685A084144EBC479F414F4391766844@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef7fa66f-aace-4067-a7b7-08d6b387c506
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2019 14:15:02.5947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6024
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8yMS8xOSwgNzo0MSBBTSwgInB2LWRyaXZlcnMtYm91bmNlc0B2bXdhcmUuY29tIG9uIGJl
aGFsZiBvZiBKb3JnZW4gSGFuc2VuIiA8cHYtZHJpdmVycy1ib3VuY2VzQHZtd2FyZS5jb20gb24g
YmVoYWxmIG9mIGpoYW5zZW5Adm13YXJlLmNvbT4gd3JvdGU6DQoNCiAgICBVcGRhdGUgdGhlIG1h
aW50YWluZXJzIGZpbGUgdG8gaW5jbHVkZSBtYWludGFpbmVycyBmb3IgdGhlIFZNd2FyZQ0KICAg
IHZtY2kgZHJpdmVyLCBhZl92c29jaywgYW5kIHRoZSB2c29jayB2bWNpIHRyYW5zcG9ydC4NCiAg
ICANCiAgICBTaWduZWQtb2ZmLWJ5OiBKb3JnZW4gSGFuc2VuIDxqaGFuc2VuQHZtd2FyZS5jb20+
DQoNCkFja2VkLWJ5OiBWaXNobnUgRGFzYSA8dmRhc2FAdm13YXJlLmNvbT4NCg0KVmlzaG51DQog
DQoNCg==
