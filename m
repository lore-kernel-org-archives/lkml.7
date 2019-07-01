Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D804EC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 17:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA52F206A3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 17:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562003346;
	bh=DpgKa1i7tOhFQEDq7WvpHneYcU01MzTAnLCFVqYQtdU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Tw9GetkV7nqTHMjvWXH6vruEjI3HBsh5MsaP0uFY92UCgZ/VR4xaj3nGypl/fIdjT
	 lIL3/mddnpyRik2ErHb1KAO601tjm4W2ZrZfdjNjCoICyjM0oaUhHbLF4KRHgCENCs
	 a+Wt26Uq/Cq7GYd5be4Q/53lh9840frNc5X00bQM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729965AbfGARtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 13:49:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:54554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729916AbfGARs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 13:48:58 -0400
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2D752184E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2019 17:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562003338;
        bh=DpgKa1i7tOhFQEDq7WvpHneYcU01MzTAnLCFVqYQtdU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BTcs+gHim9dLWUtEBAXVK9mAFqU7L5AffsZqi9dppzVKHWqMYB4+pjDREBcGpxYvT
         H8RDcC+1kaEZypyz84c8OZQVv2gjf1NB9XS4PBq1hgKmH5rVadn/hzFeJQmHNwa+r6
         K+gmx5E8Yob/3/lkbSqGkZh351HyfcrGppDjWWYg=
Received: by mail-wm1-f49.google.com with SMTP id u8so435399wmm.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 10:48:57 -0700 (PDT)
X-Gm-Message-State: APjAAAW5Mi6vEEKLqSQVfJNuxdn/pIT5Urefmr0ROY8FsLXx+ve6Uk/M
        akzUghhjjvGOMw56XRj4+zXWOksphcdww+VgzASdxA==
X-Google-Smtp-Source: APXvYqxTxD+tbmWI8DDbgP1qRuOhOFZCyJpHtcWfExGkFueDWRgYQFeF2QdtV2fezesSAyKVfpALCUEHhZcbxv+JodQ=
X-Received: by 2002:a1c:9a53:: with SMTP id c80mr232583wme.173.1562003336233;
 Mon, 01 Jul 2019 10:48:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190701130431.13391-1-colin.king@canonical.com>
In-Reply-To: <20190701130431.13391-1-colin.king@canonical.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 1 Jul 2019 10:48:43 -0700
X-Gmail-Original-Message-ID: <CALCETrVo0rJVxsYvo=abDfFCZHBuCiB0coSBXoDeP_emSZgESg@mail.gmail.com>
Message-ID: <CALCETrVo0rJVxsYvo=abDfFCZHBuCiB0coSBXoDeP_emSZgESg@mail.gmail.com>
Subject: Re: [PATCH][next] selftests/x86: fix spelling mistake "FAILT" -> "FAIL"
To:     Colin King <colin.king@canonical.com>
Cc:     Shuah Khan <shuah@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 1, 2019 at 6:04 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There is an spelling mistake in an a test error message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  tools/testing/selftests/x86/test_vsyscall.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/x86/test_vsyscall.c b/tools/testing/selftests/x86/test_vsyscall.c
> index 4602326b8f5b..a4f4d4cf22c3 100644
> --- a/tools/testing/selftests/x86/test_vsyscall.c
> +++ b/tools/testing/selftests/x86/test_vsyscall.c
> @@ -451,7 +451,7 @@ static int test_vsys_x(void)
>                 printf("[OK]\tExecuting the vsyscall page failed: #PF(0x%lx)\n",
>                        segv_err);
>         } else {
> -               printf("[FAILT]\tExecution failed with the wrong error: #PF(0x%lx)\n",
> +               printf("[FAIL]\tExecution failed with the wrong error: #PF(0x%lx)\n",
>                        segv_err);
>                 return 1;
>         }
> --
> 2.20.1
>

Acked-by: Andy Lutomirski <luto@kernel.org>
