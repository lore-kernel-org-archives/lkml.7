Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DBBC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D36562190F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388598AbfGYOrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:47:13 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38698 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387804AbfGYOrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:47:12 -0400
Received: by mail-qk1-f195.google.com with SMTP id a27so36624486qkk.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 07:47:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=htUzWSoApcDWjKb86ULmORYibBZGH80wc1z3U/svmrE=;
        b=CwgvQuOTOWdxklii1WW8fom5NF9Dg/70qwbgbKxeDJRihiZXd9egj+FlcaJ7YF2b24
         /GsIT3196s72QX8jVCHy5jy3Pl+Gi18CexQLP77BLqL+zmlevvZShS1649mr5K4LGIIf
         5/N9dA87+PlVXIy6gnnCF7c5krSmbJdUSMJIEzRSrQcLjTREf/xElsvDqcJMT3ayxMpQ
         u5wuDXk27LjHJN+c72Km4fimPQLiguqbyejaieluhd+x/4+rSQuNkpy3RlOIAK/3o+7g
         lIDZx5dLIJlu9wzVg+vXGfuGfOLk1MsEwjllxySaKaknkrfYLr1J7dWJowiGdFoAisqM
         nE9g==
X-Gm-Message-State: APjAAAXG/7zxHqSDsx4YKfdeGvy8uEPDTyH+h1izgFeUGKiV7b+kQjln
        7uPlR3WXLsJiqfHGZBCvixtOCSInxV9t1QVj3KY=
X-Google-Smtp-Source: APXvYqxjqgU3XSHj9o7/gIxoxxjJgucmzHbHBCdlZ8RrCm22EYDi4TW9jOVphvXt+/83HYCLnvd23J88dL1/ymL4qzk=
X-Received: by 2002:a37:76c5:: with SMTP id r188mr58295205qkc.394.1564066031872;
 Thu, 25 Jul 2019 07:47:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190725131257.6142-1-brgl@bgdev.pl> <20190725131257.6142-3-brgl@bgdev.pl>
In-Reply-To: <20190725131257.6142-3-brgl@bgdev.pl>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 25 Jul 2019 16:46:55 +0200
Message-ID: <CAK8P3a3Oqfs-T=5VcwJ9Z+gtaCOgj99tJ9iZTL+Nr2CrkQsefw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] media: davinci-vpbe: remove obsolete includes
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 3:13 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The driver builds fine without these.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This patch got merged into the linux-media tree earlier this week.
