Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D5BC43215
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 10:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8970D206EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 10:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfKNKzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 05:55:08 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:32918 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfKNKzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 05:55:08 -0500
Received: by mail-il1-f198.google.com with SMTP id s14so4842555ila.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 02:55:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-transfer-encoding;
        bh=2KN02+Hret5K9XJ8RO/6pyt3/Tr7SyBVb2KlAk6KGjw=;
        b=iyuHvG1WgJu3hfY6u00OSGkrLZyY4Jv+QJYArzC47R14KvxB2B4MHrG9SewjNvcPL5
         BKkc+qPGL9eAhl1/uaJaa5E3Uy0tgfgm0vBOKzAEZaJGbZO5iOko5Fu0f0WFHO8ZVNju
         LS+TDSujQQcTj6x/hE6ZGW/hlwThBSXHk3c1kWyQpLk3iz3oDzOrbk8NU4nRE9WMsJfU
         iAWqWSjfAoDDjw1O9n4Hci4vCcBGjmsGBSkMV4hkp92SiJB9sjrpJBKUAS8l8lIVGj5b
         5knGg52bh+6Cds0RJmv5KSbGj8T52OkUcht/se8RFv9rd9jEPeyOhZFLFE6SwWL+Zf79
         235A==
X-Gm-Message-State: APjAAAXnIg4FgkhijBmnAPG+BSFPLR9X9V1ioLOIrRzjZ08zLm+85UyY
        ugPwBxCitwAunfscoIo6VupQSsZMDovq4kFeEtJqVvYbbAWJ
X-Google-Smtp-Source: APXvYqxK8mY709YzkgWnRDEj/oJ4emxV7cF5cnkLUTN4QdWcP8hpDKDHCnXOi0fCi6D+VtjDFmeOrjH7r4IrNk8kp+zA83gi8wNM
MIME-Version: 1.0
X-Received: by 2002:a92:660e:: with SMTP id a14mr9321475ilc.235.1573728907222;
 Thu, 14 Nov 2019 02:55:07 -0800 (PST)
Date:   Thu, 14 Nov 2019 02:55:07 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007ce85705974c50e5@google.com>
Subject: linux-next boot error: general protection fault in __x64_sys_settimeofday
From:   syzbot <syzbot+dccce9b26ba09ca49966@syzkaller.appspotmail.com>
To:     john.stultz@linaro.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQoNCnN5emJvdCBmb3VuZCB0aGUgZm9sbG93aW5nIGNyYXNoIG9uOg0KDQpIRUFEIGNv
bW1pdDogICAgODQ2NmQyM2UgQWRkIGxpbnV4LW5leHQgc3BlY2lmaWMgZmlsZXMgZm9yIDIwMTkx
MTE0DQpnaXQgdHJlZTogICAgICAgbGludXgtbmV4dA0KY29uc29sZSBvdXRwdXQ6IGh0dHBzOi8v
c3l6a2FsbGVyLmFwcHNwb3QuY29tL3gvbG9nLnR4dD94PTEwNTdhYTFjZTAwMDAwDQprZXJuZWwg
Y29uZmlnOiAgaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20veC8uY29uZmlnP3g9N2I3ZTc3
NGFlNDg0Nzc2MA0KZGFzaGJvYXJkIGxpbms6IGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29t
L2J1Zz9leHRpZD1kY2NjZTliMjZiYTA5Y2E0OTk2Ng0KY29tcGlsZXI6ICAgICAgIGdjYyAoR0ND
KSA5LjAuMCAyMDE4MTIzMSAoZXhwZXJpbWVudGFsKQ0KDQpVbmZvcnR1bmF0ZWx5LCBJIGRvbid0
IGhhdmUgYW55IHJlcHJvZHVjZXIgZm9yIHRoaXMgY3Jhc2ggeWV0Lg0KDQpJTVBPUlRBTlQ6IGlm
IHlvdSBmaXggdGhlIGJ1ZywgcGxlYXNlIGFkZCB0aGUgZm9sbG93aW5nIHRhZyB0byB0aGUgY29t
bWl0Og0KUmVwb3J0ZWQtYnk6IHN5emJvdCtkY2NjZTliMjZiYTA5Y2E0OTk2NkBzeXprYWxsZXIu
YXBwc3BvdG1haWwuY29tDQoNClsbWzM2bWluZm8bWzM5OzQ5bV0gVXNpbmcgbWFrZWZpbGUtc3R5
bGUgY29uY3VycmVudCBib290IGluIHJ1bmxldmVsIFMuDQpbLi4uLl0gU3RhcnRpbmcgdGhlIGhv
dHBsdWcgZXZlbnRzIGRpc3BhdGNoZXI6IHVkZXZkWyAgIDEzLjY0NjI1Ml1bIFQ0MDA0XSAgDQp1
ZGV2ZFs0MDA0XTogc3RhcnRpbmcgdmVyc2lvbiAxNzUNChtbPzI1bBtbPzFjGzcbWzFHWxtbMzJt
IG9rIBtbMzk7NDltGzgbWz8yNWgbWz8wYy4NClsuLi4uXSBTeW50aGVzaXppbmcgdGhlIGluaXRp
YWwgaG90cGx1ZyBldmVudHMuLi51ZGV2ZFs0MDQwXTogIA0KcmVuYW1lICcvZGV2L3Y0bC9ieS1w
YXRoL3BsYXRmb3JtLXZpdmlkLjAtdmlkZW8taW5kZXgzLnVkZXYtdG1wJyAnL2Rldi92NGwvYnkt
cGF0aC9wbGF0Zm9ybS12aXZpZC4wLXZpZGVvLWluZGV4MycgIA0KZmFpbGVkOiBObyBzdWNoIGZp
bGUgb3IgZGlyZWN0b3J5DQoNChtbPzI1bBtbPzFjGzdbICAgMjAuODU2NDY5XVsgVDQzNTBdIGdl
bmVyYWwgcHJvdGVjdGlvbiBmYXVsdDogMDAwMCBbIzFdICANClBSRUVNUFQgU01QIEtBU0FODQpb
G1sxRyAgIDIwLjg3MjA0OF1bIFQ0MzUwXSBIYXJkd2FyZSBuYW1lOiBHb29nbGUgR29vZ2xlIENv
bXB1dFsbWzMybSBvayAgDQobWzM5OzQ5bWUgRW5naW5lL0dvb2dsZSBDb21wdXRlIEVuZ2luZSwg
QklPUyBHb29nbGUgMDEvMDEvMjAxMQ0KGzhbIBtbPzI1aBtbPzBjICBkb25lLg0KMjAuODkwMTk3
XVsgVDQzNTBdIENvZGU6IDg1IDUwIGZmIGZmIGZmIDg1IGMwIDBmIDg1IDUwIDAxIDAwIDAwIGU4
IGI4IGNkIDEwICANCjAwIDQ4IDhiIDg1IDQ4IGZmIGZmIGZmIDQ4IGMxIGU4IDAzIDQ4IDg5IGMy
IDQ4IGI4IDAwIDAwIDAwIDAwIDAwIGZjIGZmIGRmICANCjw4MD4gM2MgMDIgMDAgMGYgODUgOGEg
MDEgMDAgMDAgNDkgOGIgNzQgMjQgMDggYmYgNDAgNDIgMGYgMDAgNDggODkNClsuLi4uXSBXYWl0
aW5nIGZbICAgMjEuNTIyNTYzXVsgVDQzNTBdIFJJUDogMDAxMDpfX2RvX3N5c19zZXR0aW1lb2Zk
YXkgIA0Ka2VybmVsL3RpbWUvdGltZS5jOjIxMCBbaW5saW5lXQ0KWy4uLi5dIFdhaXRpbmcgZlsg
ICAyMS41MjI1NjNdWyBUNDM1MF0gUklQOiAwMDEwOl9fc2Vfc3lzX3NldHRpbWVvZmRheSAgDQpr
ZXJuZWwvdGltZS90aW1lLmM6MTk5IFtpbmxpbmVdDQpbLi4uLl0gV2FpdGluZyBmWyAgIDIxLjUy
MjU2M11bIFQ0MzUwXSBSSVA6ICANCjAwMTA6X194NjRfc3lzX3NldHRpbWVvZmRheSsweDE3MC8w
eDMyMCBrZXJuZWwvdGltZS90aW1lLmM6MTk5DQpvciAvZGV2IHRvIGJlIGZ1WyAgIDIxLjU1MDA3
Nl1bIFQ0MzUwXSBSU1A6IDAwMTg6ZmZmZjg4ODA5M2QwZmU1OCBFRkxBR1M6ICANCjAwMDEwMjA2
DQpsbHkgcG9wdWxhdGVkLi4uWyAgIDIxLjU1NzQ5OF1bIFQ0MzUwXSBSQVg6IGRmZmZmYzAwMDAw
MDAwMDAgUkJYOiAgDQoxZmZmZjExMDEyN2ExZmNkIFJDWDogZmZmZmZmZmY4MTYyZTkxNQ0KDQoN
Ci0tLQ0KVGhpcyBidWcgaXMgZ2VuZXJhdGVkIGJ5IGEgYm90LiBJdCBtYXkgY29udGFpbiBlcnJv
cnMuDQpTZWUgaHR0cHM6Ly9nb28uZ2wvdHBzbUVKIGZvciBtb3JlIGluZm9ybWF0aW9uIGFib3V0
IHN5emJvdC4NCnN5emJvdCBlbmdpbmVlcnMgY2FuIGJlIHJlYWNoZWQgYXQgc3l6a2FsbGVyQGdv
b2dsZWdyb3Vwcy5jb20uDQoNCnN5emJvdCB3aWxsIGtlZXAgdHJhY2sgb2YgdGhpcyBidWcgcmVw
b3J0LiBTZWU6DQpodHRwczovL2dvby5nbC90cHNtRUojc3RhdHVzIGZvciBob3cgdG8gY29tbXVu
aWNhdGUgd2l0aCBzeXpib3QuDQo=
