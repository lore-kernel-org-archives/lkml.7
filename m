Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9261C0650E
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 07:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8035C216B7
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 07:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562399935;
	bh=6COQkh4U3VVQoN9CAk4HX81w+sKnxIMS3dtGDN2ojSg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=PaWO4OOaMP0SdcH8tE8GCtEAsOq33ZCCzn1mqxNfq7l6iqFscTCs05rzhlVOhk7Px
	 aFM+iPYbUcgQA9X4bRaol72jxGLePKNCSYL8FFWalOsnl+TA3KU+GXg7EYqLtWSD2F
	 rlIoxAXq4khj11SOIPGtdZlVCA5wkWnR03RB8nA0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbfGFH6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 03:58:54 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38346 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfGFH6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 03:58:54 -0400
Received: by mail-ot1-f68.google.com with SMTP id d17so11213785oth.5;
        Sat, 06 Jul 2019 00:58:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6COQkh4U3VVQoN9CAk4HX81w+sKnxIMS3dtGDN2ojSg=;
        b=HAm/hdwGGTZVcxch7AvFGw/12QWng1eb8dg7DWpzgXzbCgLHdNXi0FDTD1HTQK8Pmx
         3crSy4c7sIDakBtQ9J77KOyb+JToPTJoTTm4SZi0Bp7Tw5dHN3AgOPFOrrJOo0FDxKmq
         bBmatNDbZUBUHE7kwel43de3PbNY2w40CfdG6tTNp7UVKw4NyMoh6CjmUjvdu8oXQKJO
         m7Evjj3Wk/4I0RxHJevPpkErvqAmFusVlzcp940IzUficF8hkF9aZ7RcJ7egJFZZE+iz
         anxsFTXZwenTgzvO6nFfTWlJ59b0pqnCbCq+WS5bDzuWUfcKZrFomojJlnGCF244iF+Z
         lOLg==
X-Gm-Message-State: APjAAAWBoh5fCIfJBl04ou55wUEn11PTST4cZn5l8Z8bmNdOBkIwwczJ
        4vuPAgzLaiAxXjNgOkyMlbqP5mBZiLhTPVuY+nc=
X-Google-Smtp-Source: APXvYqxs3fkYFf33MB5x0z6dgHzIdnZjiX1d3PHTwjm1UPH9bFhoAYVt7Ku/aN9dAKvbh4TU03F/cBhIR4URNsMsFXw=
X-Received: by 2002:a9d:6a4b:: with SMTP id h11mr3991551otn.266.1562399933246;
 Sat, 06 Jul 2019 00:58:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190705210428.8039-1-shreeya.patel23498@gmail.com>
In-Reply-To: <20190705210428.8039-1-shreeya.patel23498@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 6 Jul 2019 09:58:40 +0200
Message-ID: <CAJZ5v0hovK+BY0kozGvkyCgR5CFHpZUu71BZRjUUdCYV8fM5Hg@mail.gmail.com>
Subject: Re: [PATCH] Documentation: cpu-freq: Convert core.txt file to ReST format
To:     Shreeya Patel <shreeya.patel23498@gmail.com>
Cc:     skhan@linuxfoundation.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 5, 2019 at 11:04 PM Shreeya Patel
<shreeya.patel23498@gmail.com> wrote:
>
> Convert core file to ReST format, in order to allow it to
> be parsed by Sphinx. Make a minor change of correcting the wrong
> function name cpufreq_put_cpu to cpufreq_cpu_put.
> Also create an index.rst file in cpu-freq and add it's entry
> in the main Documentation/index.rst file.
>
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>

I've said "no" no three previous attempts and this one is not different.

I don't want to have anything .rst in Documentation/cpu-freq/.

There is a *new* admin-guide doc for cpufreq already and what is
missing is a *new* driver-api one.

Thanks!
