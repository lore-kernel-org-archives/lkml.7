Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62125C28D1C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 08:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44B122070B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 08:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfFFIyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 04:54:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:37502 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727420AbfFFIyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 04:54:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E56C8AD56;
        Thu,  6 Jun 2019 08:54:10 +0000 (UTC)
Message-ID: <1559811234.21928.9.camel@suse.com>
Subject: Re: KASAN: use-after-free Read in device_del
From:   Oliver Neukum <oneukum@suse.com>
To:     syzbot <syzbot+93f2f45b19519b289613@syzkaller.appspotmail.com>,
        andreyknvl@google.com, syzkaller-bugs@googlegroups.com,
        rafael@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Date:   Thu, 06 Jun 2019 10:53:54 +0200
In-Reply-To: <000000000000fa11f3058a69d67b@google.com>
References: <000000000000fa11f3058a69d67b@google.com>
Content-Type: multipart/mixed; boundary="=-WHPQrjiUrTPTkJwCTFpN"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WHPQrjiUrTPTkJwCTFpN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Am Montag, den 03.06.2019, 04:41 -0700 schrieb syzbot:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    69bbe8c7 usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=1684d87ca00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=193d8457178b3229
> dashboard link: https://syzkaller.appspot.com/bug?extid=93f2f45b19519b289613
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.

Will this do?

	Regards
		Oliver

--=-WHPQrjiUrTPTkJwCTFpN
Content-Disposition: attachment;
	filename*0=0001-usb-hso-initialize-so-that-we-can-tear-down-in-the-e.pat;
	filename*1=ch
Content-Transfer-Encoding: base64
Content-Type: text/x-patch;
	name="0001-usb-hso-initialize-so-that-we-can-tear-down-in-the-e.patch";
	charset="UTF-8"

RnJvbSA2ODY3YWJjMTcwMWYxODg5MmQzMmU4YWVhZjY0NDkwMWU5YmNiZjgyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBPbGl2ZXIgTmV1a3VtIDxvbmV1a3VtQHN1c2UuY29tPgpEYXRl
OiBXZWQsIDUgSnVuIDIwMTkgMTM6NDk6MjEgKzAyMDAKU3ViamVjdDogW1BBVENIXSB1c2I6IGhz
bzogaW5pdGlhbGl6ZSBzbyB0aGF0IHdlIGNhbiB0ZWFyIGRvd24gaW4gdGhlIGVycm9yCiBjYXNl
CgpJbml0dWFsaXphdGlvbiBtdXN0IGZvbGxvdyB0aGUgc2VxdWVuY2Ugc3R1ZmYgaXMgdW5kb25l
IGluIGNhc2UKd2UgYmFpbCBvdXQuIFRodXMgdGhlIHBhcmVudCBwb2ludGVyIG11c3QgYmUgc2V0
IGVhcmxpZXIuCgpTaWduZWQtb2ZmLWJ5OiBPbGl2ZXIgTmV1a3VtIDxvbmV1a3VtQHN1c2UuY29t
PgotLS0KIGRyaXZlcnMvbmV0L3VzYi9oc28uYyB8IDYgKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwg
MyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0
L3VzYi9oc28uYyBiL2RyaXZlcnMvbmV0L3VzYi9oc28uYwppbmRleCA2YTBlY2RkZmYzMTAuLjRk
OTEwMGZiOWY2ZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9uZXQvdXNiL2hzby5jCisrKyBiL2RyaXZl
cnMvbmV0L3VzYi9oc28uYwpAQCAtMjY1Myw2ICsyNjUzLDkgQEAgc3RhdGljIHN0cnVjdCBoc29f
ZGV2aWNlICpoc29fY3JlYXRlX2J1bGtfc2VyaWFsX2RldmljZSgKIAkJCQkgICAgIEJVTEtfVVJC
X1RYX1NJWkUpKQogCQlnb3RvIGV4aXQ7CiAKKwkvKiBhbmQgcmVjb3JkIHRoaXMgc2VyaWFsICov
CisJc2V0X3NlcmlhbF9ieV9pbmRleChzZXJpYWwtPm1pbm9yLCBzZXJpYWwpOworCiAJc2VyaWFs
LT5pbl9lbmRwID0gaHNvX2dldF9lcChpbnRlcmZhY2UsIFVTQl9FTkRQT0lOVF9YRkVSX0JVTEss
CiAJCQkJICAgICBVU0JfRElSX0lOKTsKIAlpZiAoIXNlcmlhbC0+aW5fZW5kcCkgewpAQCAtMjY2
OSw5ICsyNjcyLDYgQEAgc3RhdGljIHN0cnVjdCBoc29fZGV2aWNlICpoc29fY3JlYXRlX2J1bGtf
c2VyaWFsX2RldmljZSgKIAogCXNlcmlhbC0+d3JpdGVfZGF0YSA9IGhzb19zdGRfc2VyaWFsX3dy
aXRlX2RhdGE7CiAKLQkvKiBhbmQgcmVjb3JkIHRoaXMgc2VyaWFsICovCi0Jc2V0X3NlcmlhbF9i
eV9pbmRleChzZXJpYWwtPm1pbm9yLCBzZXJpYWwpOwotCiAJLyogc2V0dXAgdGhlIHByb2MgZGly
cyBhbmQgZmlsZXMgaWYgbmVlZGVkICovCiAJaHNvX2xvZ19wb3J0KGhzb19kZXYpOwogCi0tIAoy
LjE2LjQKCg==


--=-WHPQrjiUrTPTkJwCTFpN--

