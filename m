Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8247C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 09:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87FA7206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 09:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551865490;
	bh=aOoghl6CRZqXAKWz2+Vw+FfgO8GDh0CsXbaGriu3KxU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=eFEqtroRhgwuQ5Mo7jhw8NAupYqHjNUw5FnH8wCcBtqO9w8EZ9p4ExBJ+JWZsDxKA
	 s0MkC7Nd4UD0fVb0KpEn/96b5jKWVFCmhZrw47ED3lt9otyn3puI6FpIFw9KYe407/
	 cEHQHjcOjCFlqbxjKlv7mpvctM9K5BSz1rTL912s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbfCFJos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 04:44:48 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43709 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbfCFJos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 04:44:48 -0500
Received: by mail-ot1-f67.google.com with SMTP id n71so10162816ota.10;
        Wed, 06 Mar 2019 01:44:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aOoghl6CRZqXAKWz2+Vw+FfgO8GDh0CsXbaGriu3KxU=;
        b=UkteB8fYVzq3eJsPuwbhUwP5cOEZPNDJQKf1cGcSYdwh0yFCt8+7LzqubgjeH/TA1/
         9C9mCMyuJCBvO7T3qll6LB5847tvZz29zgc6xuK3U6nXRSjnO9hicJx/HLTq6FOYRAIs
         ZTVYpW5HFMt3iC/mJXOq+1RVcvJ6SdTRWo24nusPryqvNSoSX++nNvmNNIBMEy2IL4uN
         hEmx1Zxbz022ApsDRuZ9BTBF8OrjczRrWCS8+m5D4rWZBmT/K7TY75rPa/mXYqHxMG0k
         6QzfVsPPUSIigrwFoiIPyz1Bww8w/0mVfqg/J61mUQonMO9v/kuxCXSGbEsZmp2cbrTa
         38JA==
X-Gm-Message-State: APjAAAWMi9UGW3LqYzDypVpRb2MQoNZb3ZPauflQ29R/3jKjjBqeME7o
        p0wCZnBrxUW0DDslJQBTHbteNQYLs6nb8XyPAUs=
X-Google-Smtp-Source: APXvYqyteLnBACNqsUQx6/wB8tloP2vfyWPwB/J6KAEM88VtNNpAtGERZculhZ51d2CQGy0zdzv8I7KtojIif3HaSfc=
X-Received: by 2002:a9d:7547:: with SMTP id b7mr3634459otl.244.1551865485056;
 Wed, 06 Mar 2019 01:44:45 -0800 (PST)
MIME-Version: 1.0
References: <cc753578-75ba-2030-553d-f7d7d16955ef@kernel.org>
In-Reply-To: <cc753578-75ba-2030-553d-f7d7d16955ef@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 6 Mar 2019 10:44:32 +0100
Message-ID: <CAJZ5v0jg5Z6RZJjeuftWb+MBxvhUc5mdKQLfea+e29TQDRuxVw@mail.gmail.com>
Subject: Re: [GIT PULL] cpupower update for Linux 5.1-rc1
To:     shuah <shuah@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Renninger <trenn@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shuah,

On Fri, Mar 1, 2019 at 5:47 PM shuah <shuah@kernel.org> wrote:
>
> Hi Rafael,
>
> Please pull the following cpupower update for Linux 5.1-rc1.
>
> This cpupower update for Linux 5.1-rc1 consists of a patch to add
> support to display boost frequency separately from Abhishek Goel.
>
> diff is attached.

Pulled, but since my own pull requests have been sent already, this
will have to wait for the second half of the merge window.

Thanks!
