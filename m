Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2015EECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB4A32173B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbfJGNLx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 09:11:53 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:35566 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727010AbfJGNLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 09:11:52 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-79-ulVuvKaaPw-3eg4MZEtZ5w-1; Mon, 07 Oct 2019 14:11:46 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 7 Oct 2019 14:11:46 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 7 Oct 2019 14:11:46 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Nathan Chancellor' <natechancellor@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Christian Brauner <christian.brauner@ubuntu.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: [GIT PULL] usercopy structs for v5.4-rc2
Thread-Topic: [GIT PULL] usercopy structs for v5.4-rc2
Thread-Index: AQHVeuwFcYhVK5e8z06Z1VFXvM2TfadPKxGQ
Date:   Mon, 7 Oct 2019 13:11:46 +0000
Message-ID: <d0944174abe24165ac5cb63c52b89c42@AcuMS.aculab.com>
References: <20191004104116.20418-1-christian.brauner@ubuntu.com>
 <CAHk-=whxf5HVdaXqL6RgHCLzb2LNn3U2n_x4GWQZroCC+evRoA@mail.gmail.com>
 <20191004194330.GA1478788@archlinux-threadripper>
In-Reply-To: <20191004194330.GA1478788@archlinux-threadripper>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: ulVuvKaaPw-3eg4MZEtZ5w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor
> Sent: 04 October 2019 20:44
...
> > IOW, the code should have just been
> >
> >         ret = test(umem_src == NULL, "kmalloc failed");
> >         if (ret) ...
> 
> Yes, I had this as the original fix but I tried to keep the same
> intention as the original author. I should have gone with my gut. Sorry
> for the ugliness, I'll try to be better in the future.

This rather begs the question about why 'usercopy' is ever calling kmalloc() at all.
Never mind some perverted style for reporting errors.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

