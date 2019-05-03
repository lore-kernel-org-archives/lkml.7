Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED2DC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 11:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 574F9206C3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 11:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbfECLUk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 07:20:40 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:22483 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726377AbfECLUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 07:20:39 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-147-uNDlfnUDNzGCnnkqEq6Diw-1; Fri, 03 May 2019 12:20:33 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 3 May 2019 12:20:32 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 3 May 2019 12:20:32 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Joel Savitz' <jsavitz@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Micah Morton <mortonm@chromium.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Jann Horn <jannh@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Rafael Aquini <aquini@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: RE: [PATCH 2/2] prctl.2: Document the new PR_GET_TASK_SIZE option
Thread-Topic: [PATCH 2/2] prctl.2: Document the new PR_GET_TASK_SIZE option
Thread-Index: AQHVARtLvJKGJytP2U6L8JAWp4DVLqZZQYQA
Date:   Fri, 3 May 2019 11:20:32 +0000
Message-ID: <b32818a591a74efd88dd920fba530a8b@AcuMS.aculab.com>
References: <1556824391-24060-1-git-send-email-jsavitz@redhat.com>
 <1556824391-24060-3-git-send-email-jsavitz@redhat.com>
In-Reply-To: <1556824391-24060-3-git-send-email-jsavitz@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: uNDlfnUDNzGCnnkqEq6Diw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joel Savitz
> Sent: 02 May 2019 20:13
> Add a short explanation of the new PR_GET_TASK_SIZE option for the benefit
> of future generations.
> 
> Signed-off-by: Joel Savitz <jsavitz@redhat.com>
> ---
>  man2/prctl.2 | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/man2/prctl.2 b/man2/prctl.2
> index 06d8e13c7..35a6a3919 100644
> --- a/man2/prctl.2
> +++ b/man2/prctl.2
> @@ -49,6 +49,7 @@
>  .\" 2013-01-10 Kees Cook, document PR_SET_PTRACER
>  .\" 2012-02-04 Michael Kerrisk, document PR_{SET,GET}_CHILD_SUBREAPER
>  .\" 2014-11-10 Dave Hansen, document PR_MPX_{EN,DIS}ABLE_MANAGEMENT
> +.\" 2019-05-02 Joel Savitz, document PR_GET_TASK_SIZE
>  .\"
>  .\"
>  .TH PRCTL 2 2019-03-06 "Linux" "Linux Programmer's Manual"
> @@ -1375,6 +1376,14 @@ system call on Tru64).
>  for information on versions and architectures)
>  Return unaligned access control bits, in the location pointed to by
>  .IR "(unsigned int\ *) arg2" .
> +.TP
> +.B PR_GET_TASK_SIZE
> +Copy the value of TASK_SIZE to the userspace address in
> +.IR "arg2" .
> +Return
> +.B EFAULT
> +if this operation fails.
> +

Shouldn't this say what the value is?
ISTR a recent patch to change the was the 'used to be constant' TASK_SIZE is defined.
I think it might be 'The highest userspace virtual address the current
process can use.' But I might be wrong.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

