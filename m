Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC22C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 05:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B44920881
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 05:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575264980;
	bh=r1FPa7Cq2u5+A4vp9pnlsuZBfWzAI7dBWqXTa3/c1VU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Vv/jTEd9FeEOUdycKyEuaW76ibHII1jYyBz03r3c3DdveagYi/CG03VS+OiU5cSCB
	 ZQpwhHxyfPp+u5AtCJS8DnSFDJp/P3M5MzsDfBOVwi2xs88DrnaBTD3L+4oJhNEO8r
	 WdSaO2x21kJFaDhFr1MEXMC9Qb1Ia9ANuyYok1Ys=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfLBFgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 00:36:05 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43140 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfLBFgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 00:36:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zzQN8wezjT7b8g3+ghWsdGp9+x99xEeyGabO3I6sDJg=; b=U7v/I2bc5x5IaFlgbKhxfCG9/
        3alyresmA6+o81UZ1foOF28PTS51KwKjRyhlwbda2VanIfwRh3q0+xs0PR5Pb61sWpfT7oY0RI4HA
        BmF0XKuX9YTc0KHeMF0e1H9J/a9qQ9s0EFCn4qXa+xFJ5dEdAniVTm5RyzRCk9O3josCIR07amc4n
        fHUKXBwc9mQgPaDLto9J0zhXIND5sXPYfHsQlQ0xUJC1eQFjCcejbwuzm1ZtLlzEMMzA5N5sFA4/X
        jItRphDUN+6O2M/dNDs7JPp5CUdXtCm5lr7K83ptbZMotQ3Eab2VxU8xHkV/F+gOHkcfaLs7MdOQh
        4iZRJA2YA==;
Received: from [80.156.29.194] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ibeNM-0007z9-8d; Mon, 02 Dec 2019 05:36:00 +0000
Date:   Mon, 2 Dec 2019 06:35:55 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Amit Choudhary <amitchoudhary2305@gmail.com>
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        gregkh@linuxfoundation.org, rfontana@redhat.com,
        kstewart@linuxfoundation.org, tglx@linutronix.de,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] media: dvb_dummy_fe: Fix long lines
Message-ID: <20191202063555.0f75e68f@kernel.org>
In-Reply-To: <CAFzckaFfmVYV_baqV9bHrnguXfOKs42DJ2VgA4C1y2Ey-+99xQ@mail.gmail.com>
References: <20191201161542.69535-1-dwlsalmeida@gmail.com>
        <20191201161542.69535-5-dwlsalmeida@gmail.com>
        <CAFzckaFfmVYV_baqV9bHrnguXfOKs42DJ2VgA4C1y2Ey-+99xQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, 1 Dec 2019 22:07:22 +0530
Amit Choudhary <amitchoudhary2305@gmail.com> escreveu:

> +static int dvb_dummy_fe_read_signal_strength(struct dvb_frontend *fe,
> 
> > +                                            u16 *strength)
> >  
> 
> In my opinion, the arguments on new line should be just below the start of
> arguments on top line. Like this:
> 
> +static int dvb_dummy_fe_read_signal_strength(struct dvb_frontend *fe,
> +                                                                     u16
> *strength)

No, that is not the way we indent. The alignment is relative to the open
parenthesis:

  foo(arg1,
      arg2);

Btw, if you run checkpatch --strict, you'll see it complaining if the
alignment is different:

	CHECK: Alignment should match open parenthesis
	#2: FILE: a.c:2:
	+void foo(int arg1,
	+		int arg2)

> +               .caps = FE_CAN_FEC_1_2 |
> > +                       FE_CAN_FEC_2_3 |

The alignment here is given by the first argument:

   bitfield = BIT_1 |
              BIT_2 |
              BIT_3 |
              ...

or

   bitfield = BIT_1
              | BIT_2
              | BIT_3
              ...

On media, we usually prefer the first form.

Cheers,
Mauro
