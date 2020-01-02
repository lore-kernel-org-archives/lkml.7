Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B65C3276D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 06:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A82DA21655
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 06:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbgABGvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 01:51:41 -0500
Received: from mailgate1.rohmeurope.com ([178.15.145.194]:54962 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbgABGvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 01:51:40 -0500
X-AuditID: c0a8fbf4-183ff70000001fa6-91-5e0d92faa440
Received: from smtp.reu.rohmeu.com (will-cas002.reu.rohmeu.com [192.168.251.178])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id 0A.D9.08102.AF29D0E5; Thu,  2 Jan 2020 07:51:38 +0100 (CET)
Received: from WILL-MAIL001.REu.RohmEu.com ([fe80::2915:304f:d22c:c6ba]) by
 WILL-CAS002.REu.RohmEu.com ([fe80::fc24:4cbc:e287:8659%12]) with mapi id
 14.03.0439.000; Thu, 2 Jan 2020 07:51:34 +0100
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "axel.lin@ingics.com" <axel.lin@ingics.com>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] regulator: bd70528: Remove .set_ramp_delay for
 bd70528_ldo_ops
Thread-Topic: [PATCH] regulator: bd70528: Remove .set_ramp_delay for
 bd70528_ldo_ops
Thread-Index: AQHVwEqUU274yDAdXUmbzUTRoKdhqafW384AgAAAngCAAABjgA==
Date:   Thu, 2 Jan 2020 06:51:33 +0000
Message-ID: <6ff5a32a00d62ba4c35e61de0e04c2dbcad27fab.camel@fi.rohmeurope.com>
References: <20200101022406.15176-1-axel.lin@ingics.com>
         <356b68fe844846c7fa1e6b7cefae93220508e4b0.camel@fi.rohmeurope.com>
         <CAFRkauBs6QPUrco+aNaXXE0vd_0GXyXTWz0qRxNkKsH7a4f9Rg@mail.gmail.com>
In-Reply-To: <CAFRkauBs6QPUrco+aNaXXE0vd_0GXyXTWz0qRxNkKsH7a4f9Rg@mail.gmail.com>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [213.255.186.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB0E9C1694E8E843B7501C0FC7656BF8@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUgTYRjn3d22182Lc9N8XfY1IulDl2GwwkKEwiAisUSE1NOdbjS3dftI
        I0gIrC3KDxJtaqUzNUOToaGWJks0TUipjAyhoQkK6R+Zpn3Y3U6df93vnt/XA+8DMdl3oQLq
        DBaaMVB6pUiC9zb+dkeulBJphwYaYtR9VT8xdZl3SqRe/HBLoH7fVSWKwxM6nRPihMJlW4K7
        yS5K+OHecQ5PlcZmUhZbki7HoDqRIdW+aJ8RmfqEea7JsALQKnSAAIjIGDQ05BE4gATKyI8A
        PS0bxfmfAYBcjStiB4BQRMYix2cxZwgmVahieFDMaTCyGqDmkVFfkpy8gCYqP2G8KBl5nr8G
        PI5HFT3dAg7j5B70q8jtmxPkWTQ/XYfxZf0AuTsmRRwRQCYie8W4DwNyO7IXzPnMGBmK3NNL
        a2uTqO7lO4zHIWhm8t/aXIm6l704tzRG7kPPulQ8jENPyrR8ym5077ZXzK8QhAbvT+HFYKtz
        U4HTb3b6zc5NZucm8yMgbAIol9LpcygLHR3F0NYoxqjNZT9Zxlw34J9voQOsek57gAACDwiD
        AmUI0RgnSZNtyTRq8rWUWZvOWPW02QMQxJTBxJVEIk1GaKj8qzRjXKe2QVwZSkR4Sy7KSK7r
        Ek2baGadDYdQiYj5O6wxiKFz6Lxsnd7ipwUwgAuXKILNtEFDM5TVok3nriPdzJ4HRwWyveUl
        XK/ZROWyU946BA7A4pnqWgz2VT+uxWS4wWigFaFETzErJTmp1mrYKJoFoRAo5QTkggLZG97I
        mWUrBGzF0t8ArsJC+SlFATif/8d1pL5bbla16ecamC+G5Iyx4RrPqZTCqYH49uLY+bNk8Hh4
        tPrr6lTNwtHhuw17nfXXk771SDsHhdmRlf31mc0rWeUni1ZLbakpLWMxpRnt9pYHWTdchx/a
        UivepvZOv5JGvInt2+XQHLs5slOiOojOHF+8drltqNWRxshNStyspaL3Y4yZ+g89n4xwgAMA
        AA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBUaHUsIDIwMjAtMDEtMDIgYXQgMTQ6NTAgKzA4MDAsIEF4ZWwgTGluIHdyb3RlOg0KPiBW
YWl0dGluZW4sIE1hdHRpIDxNYXR0aS5WYWl0dGluZW5AZmkucm9obWV1cm9wZS5jb20+IOaWvCAy
MDIw5bm0MeaciDLml6Ug6YCx5ZubDQo+IOS4i+WNiDI6NDjlr6vpgZPvvJoNCj4gPiBIZWxsbyBB
eGVsLA0KPiA+IA0KPiA+IE9uIFdlZCwgMjAyMC0wMS0wMSBhdCAxMDoyNCArMDgwMCwgQXhlbCBM
aW4gd3JvdGU6DQo+ID4gPiBUaGUgLnNldF9yYW1wX2RlbGF5IHNob3VsZCBiZSBmb3IgYmQ3MDUy
OF9idWNrX29wcyBvbmx5Lg0KPiA+IEluZGVlZCEgT25seSB0aGUgYnVja3Mgb24gQkQ3MDUyOCBj
YW4gY2hhbmdlIHRoZSByYW1wLWRlbGF5LiBUaGFuaw0KPiA+IHlvdQ0KPiA+IGZvciBmaXhpbmcg
dGhpcyEgTWF5IEkgYXNrLCBob3cgZGlkIHlvdSBub3RpY2UgdGhpcyBwcm9sZW0/DQo+IEkganVz
dCByZWFkIHRoZSBjb2RlLg0KDQpJbXByZXNzaXZlIDopIFRoYW5rcyBhZ2FpbiENCg0KLS1NYXR0
aQ0K
