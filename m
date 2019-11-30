Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B6FC432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 06:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 048FC2075C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 06:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575096649;
	bh=RkCGi8KUIzt9hEKPbSaF214rLL9ABthDn1XmkQIvLYQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=JKcXEZRhgY528U8ZRuGuN0Fc81jvErms0QuRuatRFg1SSPw6NRiVoG3x03rU9QZON
	 oaH8uI+4LwrAgK+Nu3SIqPlX+iOvIEMqGwrxnJpss+ECxgd2QjoPwJ4UZ4bj1apKIq
	 THbzLtGEEcV2kEbRaOfqYAEdvDfnO3AJs/0qnMKg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbfK3Gur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 01:50:47 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42918 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfK3Gur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 01:50:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lnhl75Yh9S3JrwFZRH0Y3yPHQpM567JtzcYxbpZ24O4=; b=MY2qj43Th0PJ4ZigKabxEQNnL
        MHT1odOGF1iTjqjmrv0KUtMMSj8f6/ouCmG8jmNlTSWX/XdYy1O1zGZMTfk/h1XcT+KghszVbOKrg
        lIl0CGj15q9dTbo9Qe3hgfPPEmsAM0LL0Z4pLK2FQed1OI21f2lqJVnQXJlJM3ul9dVbPybCPmR+Q
        nwiPUC2g2gLgtX3lLO8A76myeF6/uWGqAxiicFEJ9M9hDAMTuF6gQqOboX7hVUPlKqgk/EfcphukH
        DcKCKhd2fmvfye6qzHEA06pWZzHQXIPb2AnRjBdSaBfDJTftry408uN9jjwhR88Madkwj/UVNf1dp
        awiCj10eA==;
Received: from [80.156.29.194] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iawaV-00022V-Vz; Sat, 30 Nov 2019 06:50:40 +0000
Date:   Sat, 30 Nov 2019 07:50:35 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
Cc:     rfontana@redhat.com, gregkh@linuxfoundation.org,
        allison@lohutok.net, kstewart@linuxfoundation.org,
        tglx@linutronix.de, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH] media: dvb_dummy_fe: place EXPORT_SYMBOL below
 corresponding function
Message-ID: <20191130075035.28fb3714@kernel.org>
In-Reply-To: <20191106183716.29170-1-dwlsalmeida@gmail.com>
References: <20191106183716.29170-1-dwlsalmeida@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed,  6 Nov 2019 15:37:16 -0300
"Daniel W. S. Almeida" <dwlsalmeida@gmail.com> escreveu:

> From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
> 
> Suggested-by: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>

Looks OK on my eyes.

> ---
>  drivers/media/dvb-frontends/dvb_dummy_fe.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/dvb-frontends/dvb_dummy_fe.c b/drivers/media/dvb-frontends/dvb_dummy_fe.c
> index 4db679cb70ad..909dac2345c4 100644
> --- a/drivers/media/dvb-frontends/dvb_dummy_fe.c
> +++ b/drivers/media/dvb-frontends/dvb_dummy_fe.c
> @@ -121,6 +121,7 @@ struct dvb_frontend* dvb_dummy_fe_ofdm_attach(void)
>  	state->frontend.demodulator_priv = state;
>  	return &state->frontend;
>  }
> +EXPORT_SYMBOL(dvb_dummy_fe_ofdm_attach);
>  
>  static const struct dvb_frontend_ops dvb_dummy_fe_qpsk_ops;
>  
> @@ -138,6 +139,7 @@ struct dvb_frontend *dvb_dummy_fe_qpsk_attach(void)
>  	state->frontend.demodulator_priv = state;
>  	return &state->frontend;
>  }
> +EXPORT_SYMBOL(dvb_dummy_fe_qpsk_attach);
>  
>  static const struct dvb_frontend_ops dvb_dummy_fe_qam_ops;
>  
> @@ -155,6 +157,7 @@ struct dvb_frontend *dvb_dummy_fe_qam_attach(void)
>  	state->frontend.demodulator_priv = state;
>  	return &state->frontend;
>  }
> +EXPORT_SYMBOL(dvb_dummy_fe_qam_attach);
>  
>  static const struct dvb_frontend_ops dvb_dummy_fe_ofdm_ops = {
>  	.delsys = { SYS_DVBT },
> @@ -253,7 +256,3 @@ static const struct dvb_frontend_ops dvb_dummy_fe_qpsk_ops = {
>  MODULE_DESCRIPTION("DVB DUMMY Frontend");
>  MODULE_AUTHOR("Emard");
>  MODULE_LICENSE("GPL");
> -
> -EXPORT_SYMBOL(dvb_dummy_fe_ofdm_attach);
> -EXPORT_SYMBOL(dvb_dummy_fe_qam_attach);
> -EXPORT_SYMBOL(dvb_dummy_fe_qpsk_attach);



Cheers,
Mauro
