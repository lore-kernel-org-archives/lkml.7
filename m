Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E48FC4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 11:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 274B221850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 11:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbfGELCm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 07:02:42 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:57954 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfGELCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 07:02:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id CAA1B6089351;
        Fri,  5 Jul 2019 13:02:38 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id yZBS0NU-Tcjd; Fri,  5 Jul 2019 13:02:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id C57C46089339;
        Fri,  5 Jul 2019 13:02:36 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5-_R_tkPqtN4; Fri,  5 Jul 2019 13:02:36 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 93528608898B;
        Fri,  5 Jul 2019 13:02:36 +0200 (CEST)
Date:   Fri, 5 Jul 2019 13:02:36 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     Colin Ian King <colin.king@canonical.com>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        kernel-janitors@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1328785502.28643.1562324556415.JavaMail.zimbra@nod.at>
In-Reply-To: <e97cc68c-c59a-1f5f-6580-40868bf16e90@cogentembedded.com>
References: <20190704222803.4328-1-colin.king@canonical.com> <b5e7709b-3494-d415-b36c-b19939a15fb5@cogentembedded.com> <4741f358-7c21-f721-e9fd-59d73876c62c@canonical.com> <e97cc68c-c59a-1f5f-6580-40868bf16e90@cogentembedded.com>
Subject: Re: [PATCH][next] ubifs: remove redundant assignment to pointer
 fname
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF60 (Linux)/8.8.12_GA_3809)
Thread-Topic: ubifs: remove redundant assignment to pointer fname
Thread-Index: k8dwB2k8+EY4AbsA12EzIID8bvM6yg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Sergei Shtylyov" <sergei.shtylyov@cogentembedded.com>
> An: "Colin Ian King" <colin.king@canonical.com>, "richard" <richard@nod.at>, "Artem Bityutskiy" <dedekind1@gmail.com>,
> "Adrian Hunter" <adrian.hunter@intel.com>, "linux-mtd" <linux-mtd@lists.infradead.org>
> CC: kernel-janitors@vger.kernel.org, "linux-kernel" <linux-kernel@vger.kernel.org>
> Gesendet: Freitag, 5. Juli 2019 12:51:53
> Betreff: Re: [PATCH][next] ubifs: remove redundant assignment to pointer fname

> On 07/05/2019 11:31 AM, Colin Ian King wrote:
> 
>>>> From: Colin Ian King <colin.king@canonical.com>
>>>>
>>>> The pointer fname rc is being assigned with a value that is never
>>>
>>>    rc?
>> 
>> Oops, cut'n'paste error. Do you want me to resend to can this be fixed
>> when it's applied?
> 
>   That's the question to the maintainers...

Please resend.

Thanks,
//richard
