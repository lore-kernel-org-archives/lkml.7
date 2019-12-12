Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32C1C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 20:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 915BB214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 20:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730900AbfLLUqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 15:46:44 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:43433 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730784AbfLLUqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 15:46:44 -0500
Received: by mail-io1-f68.google.com with SMTP id s2so44682iog.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 12:46:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xDNRaIfIrMkvYHphnB01y/NH5fNSj9A6kSMcC5caHQU=;
        b=Mgu8S05C32VuP8S1rax2ySYgHpHstR883ZzTQqghBx1S+OaWBb8Mphy7Dzf5c42+AR
         WktKGxEWREHwtyArPkCDJZLqIue/+v1Bg6vVAluH6dm8qizJAar0gwX0eFjfFeRryu33
         8distmPNeKt18d/h28H8QQN0/L+fvGBPE5gdcCh00wdNzkJgUV1rCQpV5J5wWNKZ4qt5
         BEekJzkbzDTIv6Rtbj5yy5GyHQfoEFGVBxofe0SMfeIs5n4k+jqMnBT9NOAH1l3vCU5k
         +ejIeus01IvN9/VlzjeDorXUIXkUXIeaSts08LJkzNm9AT7M3MAOzSr6r+9k2AWS5Com
         +Iqw==
X-Gm-Message-State: APjAAAW3qp7jgVAPvFvIR8I41Ara8RVN35MjqIdzCpfB9XjzSsW5nIBO
        YqjNi9d82HYvT30DaYFWtEa381EsXA+NTQOlZpCtwTGP
X-Google-Smtp-Source: APXvYqw7+ND/sVKU1kB1bap2FlPXkVUBpPHSoajRaKWT5L7gptMe0EY7q4zw+Atsv388/VZulG0hefl1XwLg6aABTto=
X-Received: by 2002:a6b:db12:: with SMTP id t18mr4350442ioc.11.1576183603403;
 Thu, 12 Dec 2019 12:46:43 -0800 (PST)
MIME-Version: 1.0
References: <20191212151244.26324-1-emaste@freefall.freebsd.org>
In-Reply-To: <20191212151244.26324-1-emaste@freefall.freebsd.org>
From:   Ed Maste <emaste@freebsd.org>
Date:   Thu, 12 Dec 2019 12:00:20 -0500
Message-ID: <CAPyFy2CgXe+8xzqEDhq+NRB-pu+kFnmxm+7GKMmkFz1uXfsa1Q@mail.gmail.com>
Subject: Re: [PATCH] perf tools: correct license on jsmn json parser
To:     Ed Maste <emaste@freefall.freebsd.org>
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Dec 2019 at 10:13, Ed Maste <emaste@freefall.freebsd.org> wrote:
>
> These files are part of the jsmn json parser, introduced in 867a979a83.
> Correct the SPDX tag to indicate that they are under the MIT license.

Oh, it looks like I made a mistake. json.h is actually part of Andi
Kleen's wrapper and I suspect should be 2-clause BSD as json.c is;
I'll leave that to Andi.

jsmn.h is MIT licensed and does have the wrong SPDX tag.
