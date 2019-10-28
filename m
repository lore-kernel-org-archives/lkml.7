Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F70CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 13:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8941720717
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 13:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729996AbfJ1NCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 09:02:12 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:44674 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729829AbfJ1NCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 09:02:11 -0400
Received: by mail-il1-f199.google.com with SMTP id 13so9593840iln.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 06:02:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-transfer-encoding;
        bh=gC/H1e2vQ5MzeSzXVR/okboKIIKlqD1bZOvOe5b3hLY=;
        b=pKQDRJNZl6odELUMq8/AK+dX4yeFyySyjIv/DIGA9OYy61/86QjYLWVPUy9knXvaoi
         pUxpCB1Dc2QtpotGBx4QS1VwtlKB83gwcsFDfdK2cchu0HVdS4noFwhCecEgP23FXDb5
         MQFeAOLgBt1Hrmsyx1O4C/+j9UsjhpuVMlIQHfEqG9H6FrPeDBj3jOXjyPDS7zFRtAWd
         +ioaP+nfrdblmCkBIO22Nt0lmQqX58k7PIWkjzEgI2JK4oUv6id40TpDPb+jf+8N5rbe
         nYSNfDki9iUI1jKY1CPVHIltiX/IUs1u6fquFqNOaAWPvCIcdDEiIImbPlC+rT8qZ0LW
         QaBw==
X-Gm-Message-State: APjAAAVHwvGDeCsY50Pu7owX/hPTHuk9FwkZHTwrz6UZYmWr/qXDLceQ
        aN9WVCv7vzkmToRsbnLVec7fBojPOigDr9dyboCkLCosprUX
X-Google-Smtp-Source: APXvYqxab6wXiPEzNePyJfeFbIQL7ARHxm4/XW9Gbwnag78FJ6G550sTfhmgJQXebR8f1jA7vOlb/T0vaHFGbKjRDYGxCMAJItfI
MIME-Version: 1.0
X-Received: by 2002:a02:b817:: with SMTP id o23mr17127828jam.42.1572267729574;
 Mon, 28 Oct 2019 06:02:09 -0700 (PDT)
Date:   Mon, 28 Oct 2019 06:02:09 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000835f920595f81bfa@google.com>
Subject: BUG: bad host encryption descriptor; descriptor is too short (0 vs 5 needed)
From:   syzbot <syzbot+48fbe2f8fdcd2fbc1242@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQoNCnN5emJvdCBmb3VuZCB0aGUgZm9sbG93aW5nIGNyYXNoIG9uOg0KDQpIRUFEIGNv
bW1pdDogICAgMjJiZTI2ZjcgdXNiLWZ1enplcjogbWFpbiB1c2IgZ2FkZ2V0IGZ1enplciBkcml2
ZXINCmdpdCB0cmVlOiAgICAgICBodHRwczovL2dpdGh1Yi5jb20vZ29vZ2xlL2thc2FuLmdpdCB1
c2ItZnV6emVyDQpjb25zb2xlIG91dHB1dDogaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20v
eC9sb2cudHh0P3g9MTZlY2NjMGY2MDAwMDANCmtlcm5lbCBjb25maWc6ICBodHRwczovL3N5emth
bGxlci5hcHBzcG90LmNvbS94Ly5jb25maWc/eD01ZmUyOWJjMzllZmY5NjI3DQpkYXNoYm9hcmQg
bGluazogaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20vYnVnP2V4dGlkPTQ4ZmJlMmY4ZmRj
ZDJmYmMxMjQyDQpjb21waWxlcjogICAgICAgZ2NjIChHQ0MpIDkuMC4wIDIwMTgxMjMxIChleHBl
cmltZW50YWwpDQpzeXogcmVwcm86ICAgICAgaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20v
eC9yZXByby5zeXo/eD0xMGQwOGU0Y2UwMDAwMA0KQyByZXByb2R1Y2VyOiAgIGh0dHBzOi8vc3l6
a2FsbGVyLmFwcHNwb3QuY29tL3gvcmVwcm8uYz94PTExZmIwN2ZmNjAwMDAwDQoNCklNUE9SVEFO
VDogaWYgeW91IGZpeCB0aGUgYnVnLCBwbGVhc2UgYWRkIHRoZSBmb2xsb3dpbmcgdGFnIHRvIHRo
ZSBjb21taXQ6DQpSZXBvcnRlZC1ieTogc3l6Ym90KzQ4ZmJlMmY4ZmRjZDJmYmMxMjQyQHN5emth
bGxlci5hcHBzcG90bWFpbC5jb20NCg0KdXNiIDEtMTogY29uZmlnIDAgaW50ZXJmYWNlIDY2IGFs
dHNldHRpbmcgMCBoYXMgMyBlbmRwb2ludCBkZXNjcmlwdG9ycywgIA0KZGlmZmVyZW50IGZyb20g
dGhlIGludGVyZmFjZSBkZXNjcmlwdG9yJ3MgdmFsdWU6IDQNCnVzYiAxLTE6IE5ldyBVU0IgZGV2
aWNlIGZvdW5kLCBpZFZlbmRvcj0xM2RjLCBpZFByb2R1Y3Q9NTYxMSwgIA0KYmNkRGV2aWNlPTQw
LjE1DQp1c2IgMS0xOiBOZXcgVVNCIGRldmljZSBzdHJpbmdzOiBNZnI9MCwgUHJvZHVjdD0wLCBT
ZXJpYWxOdW1iZXI9MA0KdXNiIDEtMTogY29uZmlnIDAgZGVzY3JpcHRvcj8/DQpod2EtaGMgMS0x
OjAuNjY6IFdpcmUgQWRhcHRlciB2MTI1LjUyIG5ld2VyIHRoYW4gZ3Jva2VkIHYxLjANCmh3YS1o
YyAxLTE6MC42NjogRklYTUU6IFVTQl9NQVhDSElMRFJFTiB0b28gbG93IGZvciBXVVNCIGFkYXB0
ZXIgKDUzIHBvcnRzKQ0KdXNiIDEtMTogQlVHOiBiYWQgaG9zdCBlbmNyeXB0aW9uIGRlc2NyaXB0
b3I7IGRlc2NyaXB0b3IgaXMgdG9vIHNob3J0ICgwIHZzICANCjUgbmVlZGVkKQ0KdXNiIDEtMTog
c3VwcG9ydGVkIGVuY3J5cHRpb24gdHlwZXM6IO+/ve+/ve+/vc+B77+977+977+9fO+/ve+/vc+B
77+977+977+977+977+977+9z4Hvv73vv73vv70NCnVzYiAxLTE6IEU6IGhvc3QgZG9lc24ndCBz
dXBwb3J0IENDTS0xIGNyeXB0bw0KaHdhLWhjIDEtMTowLjY2OiBDYW5ub3QgaW5pdGlhbGl6ZSBp
bnRlcm5hbHM6IC0xOQ0KDQoNCi0tLQ0KVGhpcyBidWcgaXMgZ2VuZXJhdGVkIGJ5IGEgYm90LiBJ
dCBtYXkgY29udGFpbiBlcnJvcnMuDQpTZWUgaHR0cHM6Ly9nb28uZ2wvdHBzbUVKIGZvciBtb3Jl
IGluZm9ybWF0aW9uIGFib3V0IHN5emJvdC4NCnN5emJvdCBlbmdpbmVlcnMgY2FuIGJlIHJlYWNo
ZWQgYXQgc3l6a2FsbGVyQGdvb2dsZWdyb3Vwcy5jb20uDQoNCnN5emJvdCB3aWxsIGtlZXAgdHJh
Y2sgb2YgdGhpcyBidWcgcmVwb3J0LiBTZWU6DQpodHRwczovL2dvby5nbC90cHNtRUojc3RhdHVz
IGZvciBob3cgdG8gY29tbXVuaWNhdGUgd2l0aCBzeXpib3QuDQpzeXpib3QgY2FuIHRlc3QgcGF0
Y2hlcyBmb3IgdGhpcyBidWcsIGZvciBkZXRhaWxzIHNlZToNCmh0dHBzOi8vZ29vLmdsL3Rwc21F
SiN0ZXN0aW5nLXBhdGNoZXMNCg==
