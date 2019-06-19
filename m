Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B41CC31E5E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 08:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E934D208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 08:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560932991;
	bh=0ll4DW7zH4OTUHDoryj5FvLDHB7fdZ2QkstqI9xjeOs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gzjUfMsADGvMvOBHu172lFx03PU9DHpAZ7mmF1CeZuJXHJZl20WLTeuYAW+0ypofR
	 MPE/A6H1TSTPrRZX8czd7SfbZe0oK1vj6+smmadMOqw8uROsdF3gZWauZyx+OcsLkA
	 OOYW1ub5XGbZHQE5q0+wPl3NXswWUjG61E/n3218=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731339AbfFSI3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 04:29:50 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37884 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731136AbfFSI3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 04:29:49 -0400
Received: by mail-oi1-f195.google.com with SMTP id t76so9915860oih.4;
        Wed, 19 Jun 2019 01:29:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ll4DW7zH4OTUHDoryj5FvLDHB7fdZ2QkstqI9xjeOs=;
        b=p9GkQ0abmd+ufpfTnHLyWHY5wp6XIaKZAGrFHPJP/EcZwi7pTGaIxeSr4t51YBqsP9
         2Zk5wgpKMSUNeSegpnoZvRIVPibzsS9P+X9KOMcTNKTItoGoemSRoUTHkh2jUpylb0RV
         8JMfAswR0LV2IeL6GrTl5xYUU+RSecRtAc/XkLw8l6NB6yB5Ejyoefx/MtV2WC/m1vRB
         73WBMd4899sc19HusBdpCiD5SzHveSAXMCLznSyYkD9+gz6MdLEdumYuOkPH7AK4jgQx
         wBVtBJUSGwHlGBQ2QXgYDBrthpFLkMEoslBsuhVXJ/fKkTsxB3wyfHUudEygu+4aN7oS
         uYaw==
X-Gm-Message-State: APjAAAXud/TiuvAvr4fCvCNilyMaDQzSuJ0qU+6Jbo5uY7JzWERULpDX
        kon8JNE1miEY/62Xecco8rnvbY/hFINR2GC0eSk=
X-Google-Smtp-Source: APXvYqxAhgS2y9uBdRjy8zluvrnMxA6YhPLGCdPogicOQ0/567vNgcp4XWXL1z66OS5T5zc+Ne+sEufHlLhmXeHsr7Y=
X-Received: by 2002:aca:d907:: with SMTP id q7mr1662790oig.68.1560932988746;
 Wed, 19 Jun 2019 01:29:48 -0700 (PDT)
MIME-Version: 1.0
References: <7812857.KkDK7346ep@kreacher> <20190619001905.GA62571@dtor-ws>
In-Reply-To: <20190619001905.GA62571@dtor-ws>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 19 Jun 2019 10:29:37 +0200
Message-ID: <CAJZ5v0jANxDYpvukieee1jwjw93fg_Q=t5t=5fqKtDWqL35EoQ@mail.gmail.com>
Subject: Re: [PATCH] PM: suspend: Rename pm_suspend_via_s2idle()
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 2:19 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Rafael,
>
> On Tue, Jun 18, 2019 at 10:18:28AM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > The name of pm_suspend_via_s2idle() is confusing, as it doesn't
> > reflect the purpose of the function precisely enough and it is
> > very similar to pm_suspend_via_firmware(), which has a different
> > purpose, so rename it as pm_suspend_default_s2idle() and update
> > its only caller, i8042_register_ports(), accordingly.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> I assume you'll take it through your tree...

I will.

> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks!
