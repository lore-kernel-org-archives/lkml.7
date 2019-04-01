Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF56C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD42E218FF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbfDAOq5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 10:46:57 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:53099 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726514AbfDAOq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 10:46:56 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-209-_UCUwBC3ON-jk56l_yeMxw-1; Mon, 01 Apr 2019 15:46:50 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 1 Apr 2019 15:47:55 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 1 Apr 2019 15:47:55 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'gregkh@linuxfoundation.org'" <gregkh@linuxfoundation.org>,
        "Andrey Abramov" <st5pub@yandex.ru>
CC:     George Spelvin <lkml@sdf.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "dchinner@redhat.com" <dchinner@redhat.com>,
        "dedekind1@gmail.com" <dedekind1@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "jlbec@evilplan.org" <jlbec@evilplan.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "mark@fasheh.com" <mark@fasheh.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>,
        "paulus@samba.org" <paulus@samba.org>,
        "richard@nod.at" <richard@nod.at>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "vgupta@synopsys.com" <vgupta@synopsys.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH 5/5] Lib: sort.h: replace int size with size_t size in the
 swap function
Thread-Topic: [PATCH 5/5] Lib: sort.h: replace int size with size_t size in
 the swap function
Thread-Index: AQHU57BB1hN4l4tmIUuL1+h9cp5f16YnYvDQ
Date:   Mon, 1 Apr 2019 14:47:55 +0000
Message-ID: <cd57af9a2c1e494cbc8631a0347831dc@AcuMS.aculab.com>
References: <18626931553963861@sas1-b3ec53dbc12b.qloud-c.yandex.net>
 <20467491553964233@myt4-c0b480c282c8.qloud-c.yandex.net>
 <20190330183826.GB21828@kroah.com> <201903302015.x2UKFnSL003850@sdf.org>
 <20434561554015618@myt1-cd60b8ae9bb9.qloud-c.yandex.net>
 <20190331105412.GA9393@kroah.com>
In-Reply-To: <20190331105412.GA9393@kroah.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: _UCUwBC3ON-jk56l_yeMxw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: gregkh@linuxfoundation.org
> Sent: 31 March 2019 11:54
...
> Yes, "int" is a very nice variable for "size", you need to explain why
> it is better to use size_t here please.

Actually, on x86_64 you probably want 'unsigned int' to avoid the
compiler having to generate a sign-extending register move if the
value is ever used in a 64bit expression (eg an address calculation).

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

