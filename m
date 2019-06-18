Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD9BC31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 11:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C19392082C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 11:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbfFRLej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 07:34:39 -0400
Received: from mail1.bemta24.messagelabs.com ([67.219.250.2]:57159 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729698AbfFRLei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 07:34:38 -0400
Received: from [67.219.251.51] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-c.us-west-2.aws.symcld.net id 4B/04-08344-B4CC80D5; Tue, 18 Jun 2019 11:34:35 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpik+JIrShJLcpLzFFi42LxThM+put9hiP
  W4OB3CYvmxevZLLYfFbC4vGsOm8WiZa3MDiweO2fdZffYP3cNu8fnTXIBzFGsmXlJ+RUJrBkf
  Vx9hK3ggW3Hn9z7WBsY+mS5GLg4hgS2MErumPGWBcDYzSpycu4EJwjnIKHF+RTdbFyMnB5uAo
  8TXn4/ZQWwRAWOJ/rOz2EGKmAVOM0q0HmphAUkICzhITNn2hg2iyFHiy8IvjBC2m8SJ209Yux
  g5OFgEVCW+LzADCfMKuEt0Xp8NVi4kcIZR4sUqJhCbU0Bf4uL7GWAjGQXEJL6fWgMWZxYQl7j
  1ZD6YLSEgIvHw4mk2CFtU4uXjf6wQtoHE1qX7WEBWSQgoSPx/wQHRmibxbtZ/Joi1ghInZz5h
  gVirK3F5/j/2CYxis5BsmIWkZRaSFoi4jsSC3Z/YIGxtiWULXzND2FkSW75vhbL9JU58vMU+C
  xxC1xglmpsaoRKKElO6H7IvYORcxWiRVJSZnlGSm5iZo2toYKBraGika2hsDqTN9RKrdJP1So
  t1y1OLS3SN9BLLi/WKK3OTc1L08lJLNjECE0JKQWfpDsYZB17rHWKU5GBSEuVNimaPFeJLyk+
  pzEgszogvKs1JLT7EKMPBoSTB++oUR6yQYFFqempFWmYOMDnBpCU4eJREeINOA6V5iwsSc4sz
  0yFSpxiNOSa8nLuImePg0XmLmIVY8vLzUqXEeVVBSgVASjNK8+AGwZLmJUZZKWFeRgYGBiGeg
  tSi3MwSVPlXjOIcjErCvGtBpvBk5pXA7XsFdAoT0CmPlrKBnFKSiJCSamCSLT/p8+y13oslL3
  e2rJq/ITzhm9GXHe8ZNsZnrHzJcv1y0exd7hM+N8/g1bc/LOO36Cc7v/fZgvoTOf7rRXgP3T/
  bJGzloStaKSfVLWXsfSBL6MtmtmMhinaLE+2MNDtceq57dpnmqaV5HVe/spbHPTHmlFhjT77i
  hqrz0p+ztG60zrtz/EP7eamWKSkBVdHnv/5v3vuo/+sXTZX3711OxQmdPrxkdUtAfBAL+5TNT
  2donmtY/Lv0p0o9N4fJ7i013CePGnI+OLjhD+8dhU8tlu/m1QZOlt4W/lk6/bz8KYmdTlxplt
  P6LI4VmxneyFgk5Tw5e0J8kld8iKiA9caNJWc++hjd4Va/Hvvm8RUlluKMREMt5qLiRAAUOeS
  aFQQAAA==
X-Env-Sender: Kiruthika.Varadarajan@harman.com
X-Msg-Ref: server-18.tower-363.messagelabs.com!1560857673!10070915!2
X-Originating-IP: [75.102.19.198]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 22130 invoked from network); 18 Jun 2019 11:34:35 -0000
Received: from unknown.ord.scnet.net (HELO HICGWSMB09.ad.harman.com) (75.102.19.198)
  by server-18.tower-363.messagelabs.com with DHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 18 Jun 2019 11:34:35 -0000
Received: from HICGWSMB08.ad.harman.com (10.10.24.109) by
 HICGWSMB09.ad.harman.com (10.10.24.241) with Microsoft SMTP Server (TLS) id
 15.0.1365.1; Tue, 18 Jun 2019 07:34:33 -0400
Received: from HICGWSMB01.ad.harman.com (10.10.24.94) by
 HICGWSMB08.ad.harman.com (10.10.24.109) with Microsoft SMTP Server (TLS) id
 15.0.1365.1; Tue, 18 Jun 2019 07:34:33 -0400
Received: from HICGWSMB01.ad.harman.com ([fe80::941a:f5b7:534a:7737]) by
 HICGWSMB01.ad.harman.com ([fe80::941a:f5b7:534a:7737%13]) with mapi id
 15.00.1365.000; Tue, 18 Jun 2019 06:34:33 -0500
From:   "Varadarajan, Kiruthika" <Kiruthika.Varadarajan@harman.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <balbi@ti.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kiruthikanv@gmail.com" <kiruthikanv@gmail.com>
Subject: RE: [EXTERNAL] Re: Kernel patch  in USB 4.4.138 Version
Thread-Topic: [EXTERNAL] Re: Kernel patch  in USB 4.4.138 Version
Thread-Index: AQHVHTkp8UnjGujKFk+69XE7CW1vK6ahJuHQgAACNTCAAGYCgP//yZ1w
Date:   Tue, 18 Jun 2019 11:34:32 +0000
Message-ID: <07d0eff017c84006a87aa46af54e1ded@HICGWSMB01.ad.harman.com>
References: <6e521b173bd24197930c764dc5fe9ad1@HICGWSMB01.ad.harman.com>
 <20190607135853.GB14665@kroah.com>
 <61ab2bb8e87e4c6a967722a4ae757a4a@HICGWSMB01.ad.harman.com>
 <20190618094737.GB10451@kroah.com>
In-Reply-To: <20190618094737.GB10451@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.10.24.164]
Content-Type: multipart/mixed;
        boundary="_002_07d0eff017c84006a87aa46af54e1dedHICGWSMB01adharmancom_"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_002_07d0eff017c84006a87aa46af54e1dedHICGWSMB01adharmancom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Greg,
 Now I ran checkpatch and this patch is against kernel version 5.1.
 Checkpatch run is clean. Could you check my patch now.

Thanks and Regards,
Kiruthika. NV

-----Original Message-----
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>=20
Sent: Tuesday, June 18, 2019 3:18 PM
To: Varadarajan, Kiruthika <Kiruthika.Varadarajan@harman.com>
Cc: Felipe Balbi <balbi@ti.com>; linux-usb@vger.kernel.org; linux-kernel@vg=
er.kernel.org; kiruthikanv@gmail.com
Subject: Re: [EXTERNAL] Re: Kernel patch in USB 4.4.138 Version

On Tue, Jun 18, 2019 at 08:43:56AM +0000, Varadarajan, Kiruthika wrote:
> Hi Greg,
>  Please ignore my previous email and here is the patch on top of 4.4.x st=
able version.
>  Could you please review the attached patch.

Also, always use scripts/checkpatch.pl on your patch, it has a number of ob=
vious coding style issues that prevent it from being accepted by anyone.

thanks,

greg k-h

--_002_07d0eff017c84006a87aa46af54e1dedHICGWSMB01adharmancom_
Content-Type: application/octet-stream;
	name="USB-Fix-race-between-gether_disconnect-and-rx_submit.patch"
Content-Description: USB-Fix-race-between-gether_disconnect-and-rx_submit.patch
Content-Disposition: attachment;
	filename="USB-Fix-race-between-gether_disconnect-and-rx_submit.patch";
	size=1605; creation-date="Tue, 18 Jun 2019 08:42:27 GMT";
	modification-date="Tue, 18 Jun 2019 11:32:14 GMT"
Content-Transfer-Encoding: base64

RnJvbSA4OTdmYjJkMDY1M2I0ODFiODNkNzc2ODVlNGIyMGJlNzAyMDI3YWZjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBrdmFyYWRhcmFqYW4gPEtpcnV0aGlrYS5WYXJhZGFyYWphbkBo
YXJtYW4uY29tPgpEYXRlOiBUdWUsIDE4IEp1biAyMDE5IDExOjI5OjQ5ICswMDAwClN1YmplY3Q6
IFtQQVRDSF0gIFVTQjogRml4IHJhY2UgYmV0d2VlbiBnZXRoZXJfZGlzY29ubmVjdCBhbmQgcnhf
c3VibWl0CgogIE9uIHNwaW4gbG9jayByZWxlYXNlIGluIHJ4X3N1Ym1pdCwgZ2V0aGVyX2Rpc2Nv
bm5lY3QgZ2V0CiAgYSBjaGFuY2UgdG8gcnVuLCBpdCBtYWtlcyBwb3J0X3VzYiBOVUxMLCByeF9z
dWJtaXQgYWNjZXNzCiAgTlVMTCBwb3J0IFVTQiwgaGVuY2UgbnVsbCBwb2ludGVyIGNyYXNoLgoK
ICBGaXhlZCBieSByZWxlYXNpbmcgdGhlIGxvY2sgaW4gcnhfc3VibWl0IGFmdGVyIHBvcnRfdXNi
CiAgaXMgdXNlZC4KClNpZ25lZC1vZmYtYnk6IEtWYXJhZGFyYWphbiA8S2lydXRoaWthLlZhcmFk
YXJhamFuQGhhcm1hbi5jb20+Ci0tLQogZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL3VfZXRo
ZXIuYyB8IDcgKysrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMyBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vdV9ldGhl
ci5jIGIvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL3VfZXRoZXIuYwppbmRleCA3MzdiZDc3
Li43NmNmMWU0IDEwMDY0NAotLS0gYS9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vdV9ldGhl
ci5jCisrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91X2V0aGVyLmMKQEAgLTE4Niwx
MSArMTg2LDExIEBAIHN0YXRpYyB2b2lkIGRlZmVyX2tldmVudChzdHJ1Y3QgZXRoX2RldiAqZGV2
LCBpbnQgZmxhZykKIAkJb3V0ID0gZGV2LT5wb3J0X3VzYi0+b3V0X2VwOwogCWVsc2UKIAkJb3V0
ID0gTlVMTDsKLQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZkZXYtPmxvY2ssIGZsYWdzKTsKIAot
CWlmICghb3V0KQorCWlmICghb3V0KSB7CisJCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmRldi0+
bG9jaywgZmxhZ3MpOwogCQlyZXR1cm4gLUVOT1RDT05OOwotCisJfQogCiAJLyogUGFkZGluZyB1
cCB0byBSWF9FWFRSQSBoYW5kbGVzIG1pbm9yIGRpc2FncmVlbWVudHMgd2l0aCBob3N0LgogCSAq
IE5vcm1hbGx5IHdlIHVzZSB0aGUgVVNCICJ0ZXJtaW5hdGUgb24gc2hvcnQgcmVhZCIgY29udmVu
dGlvbjsKQEAgLTIxNSw2ICsyMTUsNyBAQCBzdGF0aWMgdm9pZCBkZWZlcl9rZXZlbnQoc3RydWN0
IGV0aF9kZXYgKmRldiwgaW50IGZsYWcpCiAJaWYgKGRldi0+cG9ydF91c2ItPmlzX2ZpeGVkKQog
CQlzaXplID0gbWF4X3Qoc2l6ZV90LCBzaXplLCBkZXYtPnBvcnRfdXNiLT5maXhlZF9vdXRfbGVu
KTsKIAorCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmRldi0+bG9jaywgZmxhZ3MpOwogCXNrYiA9
IF9fbmV0ZGV2X2FsbG9jX3NrYihkZXYtPm5ldCwgc2l6ZSArIE5FVF9JUF9BTElHTiwgZ2ZwX2Zs
YWdzKTsKIAlpZiAoc2tiID09IE5VTEwpIHsKIAkJREJHKGRldiwgIm5vIHJ4IHNrYlxuIik7Ci0t
IAoxLjkuMQoK

--_002_07d0eff017c84006a87aa46af54e1dedHICGWSMB01adharmancom_--
