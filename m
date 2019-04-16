Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8524EC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A83E20868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555402645;
	bh=hdXhWy1CSh2QxvC07T9SLLzVG53VqiIH8m00Mk8CYKE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Lo8Ews0+ZvtLLtURhfKzgI9p2ckuHjSiHJJC2ZCsS8swz5KM8byMOSgkkjgIeML2L
	 bOek2SxQr4/olTzM+xg2QsaIajaiad0uEcVUfmiLJiXOwWoEr1m6o0w8y9k9CDVc50
	 4P4Uf6SUYB8KJ4iK1TvnlAwy0iZFadCUa/tFsFTo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbfDPIRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 04:17:24 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38725 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfDPIRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 04:17:24 -0400
Received: by mail-oi1-f196.google.com with SMTP id a6so16191401oie.5;
        Tue, 16 Apr 2019 01:17:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hdXhWy1CSh2QxvC07T9SLLzVG53VqiIH8m00Mk8CYKE=;
        b=LnTuHTM3PeD6zB5kI1Kv7UnSOsUVcnYSZrqcV8FSID+A+I9q5kZ5ZrlBGqfxdIVkHI
         n+KY0TogeUYiDVVuigOjHxvitrs+RwlwHj2mD1DroVz8J3bqri7n1fA6295umcIMH5Xe
         OlDil7En5Uca8puGRngBh+DikXUoIeA9Wu62yOIknzs0w6AyZjJwEVOFLQCcR6q4pXrI
         K9LfJgtWScq6Io4p5oJ3qof1vs0dvhG8h9VVyp87+nx++JfVM0DBHCz1r1+Gj9naJ+Bf
         Sz+u7C6WdJzOPpA/ysCr+/nUragx141WGTQDuBjkoy2Y4vn+M6DobJ1nMAMWUsWJs9nv
         grxw==
X-Gm-Message-State: APjAAAXJjspp4xy7uB954macQsTv0kXkA9jYr6ODnGw27AqYusMB3OWd
        9h4uxMe41xR8V8UBkKwsfU8r/XkC75I8e2/9j4c=
X-Google-Smtp-Source: APXvYqw3JaTshwmeP+ePDfp8RonesZuH8b7593v/zcl1/zsuSUHm12jf2hIdHvJAglYRJ9AoJBvKmQWTsqCl3F9mQO4=
X-Received: by 2002:aca:6289:: with SMTP id w131mr22187407oib.84.1555402643214;
 Tue, 16 Apr 2019 01:17:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1555382110.git.mchehab+samsung@kernel.org> <10802a7ac16958a2786c2fc083fb5cb50eb7ebb9.1555382110.git.mchehab+samsung@kernel.org>
In-Reply-To: <10802a7ac16958a2786c2fc083fb5cb50eb7ebb9.1555382110.git.mchehab+samsung@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 16 Apr 2019 10:17:11 +0200
Message-ID: <CAJZ5v0hZK07zQzmD6J0J5dBUAecpE_31_W5Ade5UpWrsWBeU+Q@mail.gmail.com>
Subject: Re: [PATCH 02/57] docs: acpi: convert text files to ReST
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 5:02 AM Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
>
> Most of the files are already in good shape, making easier to
> convert them to ReST by adding proper title markups and
> addressing some identation and markups to properly format the
> document.

There is concurrent work on this under way, please see
https://marc.info/?t=155381845300002&r=2&w=2

I'd prefer that one to continue, honestly.

Thanks,
Rafael
