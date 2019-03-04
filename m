Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4482EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F6E920863
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfCDI02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:26:28 -0500
Received: from mx1.unisoc.com ([222.66.158.135]:27604 "EHLO SHSQR01.unisoc.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726264AbfCDI0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:26:25 -0500
X-Greylist: delayed 2968 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Mar 2019 03:26:24 EST
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
        by SHSQR01.unisoc.com with ESMTP id x247ZcJQ098298
        for <linux-kernel@vger.kernel.org>; Mon, 4 Mar 2019 15:35:38 +0800 (CST)
        (envelope-from Vincent.Wang@unisoc.com)
Received: from ig2.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
        by SHSQR01.spreadtrum.com with ESMTPS id x247YLgS094397
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NO);
        Mon, 4 Mar 2019 15:34:21 +0800 (CST)
        (envelope-from Vincent.Wang@unisoc.com)
Received: from BJMBX02.spreadtrum.com (10.0.64.8) by BJMBX02.spreadtrum.com
 (10.0.64.8) with Microsoft SMTP Server (TLS) id 15.0.847.32; Mon, 4 Mar 2019
 15:35:16 +0800
Received: from BJMBX02.spreadtrum.com ([::1]) by BJMBX02.spreadtrum.com
 ([fe80::c9e4:4931:cd9a:28bc%19]) with mapi id 15.00.0847.030; Mon, 4 Mar 2019
 15:35:04 +0800
From:   =?gb2312?B?V2FuZywgVmluY2VudCAozfXV+Sk=?= <Vincent.Wang@unisoc.com>
To:     Quentin Perret <quentin.perret@arm.com>,
        =?gb2312?B?WmhhbmcsIENodW55YW4gKNXFtLrR3ik=?= 
        <Chunyan.Zhang@unisoc.com>
CC:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIFY0XSBzY2hlZC9jcHVmcmVxOiBpbml0aWFsaXplIGlv?=
 =?gb2312?B?d2FpdF9ib29zdF9tYXggYW5kIGlvd2FpdF9ib29zdCB3aXRoIGNwdSBjYXBh?=
 =?gb2312?Q?city?=
Thread-Topic: [PATCH V4] sched/cpufreq: initialize iowait_boost_max and
 iowait_boost with cpu capacity
Thread-Index: AQHUyprCR4vLXD8BrkqaGh/KshRMf6XrIC+AgBAB/ko=
Date:   Mon, 4 Mar 2019 07:35:04 +0000
Message-ID: <9099990618e242e1bab77ce3f9d9b1e3@BJMBX02.spreadtrum.com>
References: <1550831866-32749-1-git-send-email-chunyan.zhang@unisoc.com>,<20190222105957.wxhlcmoag5f3i4fi@queper01-lin>
In-Reply-To: <20190222105957.wxhlcmoag5f3i4fi@queper01-lin>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.0.74.90]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MAIL: SHSQR01.spreadtrum.com x247YLgS094397
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGlkIHlvdSBtZWFuIHRoZSB2YWx1ZSBvZiBhcmNoX3NjYWxlX2NwdV9jYXBhY2l0eSgpIGlzIGNo
YW5nZWQgaW4gY3B1X2NhcGFjaXR5X3N0b3JlKCk/CklmIHNvLCBJIGNhbiByZXN0YXJ0IHNjaGVk
dXRpbCBnb3Zlcm5vciBhZnRlciBuZXcgY2FwYWNpdHkgaXMgdXBkYXRlZC4KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwq3orz+yMs6IFF1ZW50aW4gUGVycmV0IDxxdWVu
dGluLnBlcnJldEBhcm0uY29tPgq3osvNyrG85DogMjAxOcTqMtTCMjLI1SAxODo1OQrK1bz+yMs6
IFpoYW5nLCBDaHVueWFuICjVxbS60d4pCrOty806IEluZ28gTW9sbmFyOyBQZXRlciBaaWpsc3Ry
YTsgV2FuZywgVmluY2VudCAozfXV+Sk7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IENo
dW55YW4gWmhhbmcK1vfM4jogUmU6IFtQQVRDSCBWNF0gc2NoZWQvY3B1ZnJlcTogaW5pdGlhbGl6
ZSBpb3dhaXRfYm9vc3RfbWF4IGFuZCBpb3dhaXRfYm9vc3Qgd2l0aCBjcHUgY2FwYWNpdHkKCk9u
IEZyaWRheSAyMiBGZWIgMjAxOSBhdCAxODozNzo0NiAoKzA4MDApLCBDaHVueWFuIFpoYW5nIHdy
b3RlOgo+IEBAIC04MjMsNiArODIzLDggQEAgc3RhdGljIGludCBzdWdvdl9zdGFydChzdHJ1Y3Qg
Y3B1ZnJlcV9wb2xpY3kgKnBvbGljeSkKPiAgewo+ICAgICAgIHN0cnVjdCBzdWdvdl9wb2xpY3kg
KnNnX3BvbGljeSA9IHBvbGljeS0+Z292ZXJub3JfZGF0YTsKPiAgICAgICB1bnNpZ25lZCBpbnQg
Y3B1Owo+ICsgICAgIHVuc2lnbmVkIGxvbmcgbWF4X2NhcCA9IGFyY2hfc2NhbGVfY3B1X2NhcGFj
aXR5KE5VTEwsIHBvbGljeS0+Y3B1KTsKPiArICAgICB1bnNpZ25lZCBsb25nIG1pbl9jYXAgPSBt
YXhfY2FwICogcG9saWN5LT5taW4gLyBwb2xpY3ktPmNwdWluZm8ubWF4X2ZyZXE7Cj4KPiAgICAg
ICBzZ19wb2xpY3ktPmZyZXFfdXBkYXRlX2RlbGF5X25zID0gc2dfcG9saWN5LT50dW5hYmxlcy0+
cmF0ZV9saW1pdF91cyAqIE5TRUNfUEVSX1VTRUM7Cj4gICAgICAgc2dfcG9saWN5LT5sYXN0X2Zy
ZXFfdXBkYXRlX3RpbWUgICAgICAgID0gMDsKPiBAQCAtODM3LDcgKzgzOSw5IEBAIHN0YXRpYyBp
bnQgc3Vnb3Zfc3RhcnQoc3RydWN0IGNwdWZyZXFfcG9saWN5ICpwb2xpY3kpCj4gICAgICAgICAg
ICAgICBtZW1zZXQoc2dfY3B1LCAwLCBzaXplb2YoKnNnX2NwdSkpOwo+ICAgICAgICAgICAgICAg
c2dfY3B1LT5jcHUgICAgICAgICAgICAgICAgICAgICA9IGNwdTsKPiAgICAgICAgICAgICAgIHNn
X2NwdS0+c2dfcG9saWN5ICAgICAgICAgICAgICAgPSBzZ19wb2xpY3k7Cj4gLSAgICAgICAgICAg
ICBzZ19jcHUtPmlvd2FpdF9ib29zdF9tYXggICAgICAgID0gcG9saWN5LT5jcHVpbmZvLm1heF9m
cmVxOwo+ICsgICAgICAgICAgICAgc2dfY3B1LT5tYXggICAgICAgICAgICAgICAgICAgICA9IG1h
eF9jYXA7Cj4gKyAgICAgICAgICAgICBzZ19jcHUtPm1pbiAgICAgICAgICAgICAgICAgICAgID0g
bWluX2NhcDsKPiArICAgICAgICAgICAgIHNnX2NwdS0+aW93YWl0X2Jvb3N0X21heCAgICAgICAg
PSBtYXhfY2FwOwoKVW5mb3J0dW5hdGVseSwgSSBkb24ndCB0aGluayB5b3UgY2FuIGRvIHRoYXQg
b25seSBoZXJlLiBUaGUgcmV0dXJuIHZhbHVlCm9mIGFyY2hfc2NhbGVfY3B1X2NhcGFjaXR5KCkg
Y2FuIGNoYW5nZSBhdCBydW4gdGltZS4gQW5kIGl0IGRvZXMgb24gYXJtNjQsCnNlZSBkcml2ZXJz
L2Jhc2UvYXJjaF90b3BvbG9neS5jLgoKPiAgICAgICB9Cj4KPiAgICAgICBmb3JfZWFjaF9jcHUo
Y3B1LCBwb2xpY3ktPmNwdXMpIHsKPiAtLQo+IDIuMTcuMQo+CgpUaGFua3MsClF1ZW50aW4K
