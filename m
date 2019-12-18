Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143A6C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 17:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDDBC20717
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 17:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfLRR2S convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 12:28:18 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:38039 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726960AbfLRR2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 12:28:17 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-11-xlA0vERvPA2EP5h6SwxyBg-1; Wed, 18 Dec 2019 17:28:13 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 18 Dec 2019 17:28:13 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 18 Dec 2019 17:28:13 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Steven Rostedt' <rostedt@goodmis.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sudip Mukherjee" <sudipm.mukherjee@gmail.com>
Subject: RE: ftrace trace_raw_pipe format
Thread-Topic: ftrace trace_raw_pipe format
Thread-Index: AdW0/hn3Ss2VXYeUS7iB4GPS8sdlIgAK/t2AACd1JMA=
Date:   Wed, 18 Dec 2019 17:28:13 +0000
Message-ID: <3df0aa9c69ec4d2086b96eb032a1a0df@AcuMS.aculab.com>
References: <e8f9744ddffc4527b222ce72d41c61a1@AcuMS.aculab.com>
 <20191217173403.61f4e2d8@gandalf.local.home>
In-Reply-To: <20191217173403.61f4e2d8@gandalf.local.home>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: xlA0vERvPA2EP5h6SwxyBg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt
> Sent: 17 December 2019 22:34
>
> > I'm trying to 'grok' the trace_raw_pipe data that ftrace generates.
> > I've some 3rd party code that post-processes it, but doesn't like wrapped traces
> > because (I think) the traces from different cpus start at different times.
> >
> > I can't seem to find any documentation at all...
...
> You may want to use libtraceevent (which will, hopefully, soon
> be in debian!). Attached is a simple program that reads the data using
> it and prints out the format.

The problem is that I don't want to print the trace, I want to fix
some trace files so that another program doesn't barf at them.

I guess I can try to reverse engineer the library code.

It would also be nice if there was a way that some standard program
(like cat) could read out the trace files without blocking at the end
when the trace is inactive.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

