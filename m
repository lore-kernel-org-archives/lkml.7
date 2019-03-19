Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B195CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F502133D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553008360;
	bh=3X5AiXiKaQ+A7ubiTxZxyJQbo3bdfQ8VWacuD0Hg3bA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fE70/xrt2hLK7XUe4Jg+X28mM/egFV/91dHGeO85cDU1cHeEEsTZORXZFZ5zyspeJ
	 3CsGy3lEw0BPsJ4XGk3Uco253yX3tQMP9C5oi8QFsH0YGwbqiSikyWj88AHmlE1lnn
	 RLsabpXIrKYRJoh6syf3q0tTa3AMAKzCw1Hv6OPc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfCSPMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 11:12:39 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35847 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbfCSPMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 11:12:38 -0400
Received: by mail-ed1-f66.google.com with SMTP id e4so16935482edi.3;
        Tue, 19 Mar 2019 08:12:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AS3EvV7rlYAaswBBgvJO/ZK6uOlgHoPPO+mfzZyVHjA=;
        b=rRTInG0YQgxaYPUIHiRgPJcWQuyCzU6oAafO7wtqrE0MbNGwod5zcecQV3ZE6FhyUq
         2bfy0e3gS92LM7CrycN0iMyV5IKrG6s0+3D+fELKbwjGc+HPV/EtA9cpPGYpM6mgNYjz
         MgxE8rufbE10GAiXFUHPvcehw1pm6HwUcOR7KIWflnHBO/KBAQ0shWSCvRBfD88ym039
         E0gcTw8jTIsaY6wFMAhI4TugMmVcFKbrva/E0JGJZxb34R0/ipGf7XoodXcAeFNwb2iV
         GhbwLoUZjTIq0qujPzo+x/JswkCkqZKlcurAe56GSJnEUtgmsCvQgnKQR6YvFLPldvb3
         RLoA==
X-Gm-Message-State: APjAAAW38b1nnKh2lCpDTTsK0G96GCNA9I/x9q92D4iz1v2NI5Md81oZ
        s6KbWt/8jzV21KQ9fk7ApXSt+WMqa0pt+Xpjkxw=
X-Google-Smtp-Source: APXvYqzF5AHid8X6We1iIp/73ILAM4ji6Y2hi29Khf4Hj/a/tqEcsTfPuucR+V42BZ+CVFFw2EJUo9+GB74bcTvIVrk=
X-Received: by 2002:a17:906:7854:: with SMTP id p20mr14245685ejm.29.1553008356832;
 Tue, 19 Mar 2019 08:12:36 -0700 (PDT)
MIME-Version: 1.0
References: <1549982079-23516-1-git-send-email-darcari@redhat.com> <1365e035-3218-aff5-6d86-05215ce25073@redhat.com>
In-Reply-To: <1365e035-3218-aff5-6d86-05215ce25073@redhat.com>
From:   Len Brown <lenb@kernel.org>
Date:   Tue, 19 Mar 2019 08:12:25 -0700
Message-ID: <CAJvTdKnzLgx35KSxaZQt+YnTqSHZAX_maNu2D0R9ds8xYwW6NA@mail.gmail.com>
Subject: Re: [PATCH] tools/power turbostat: return the exit status of a command
To:     David Arcari <darcari@redhat.com>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Jirka Hladky <jhladky@redhat.com>,
        linux-kernel@vger.kernel.org, Prarit Bhargava <prarit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Len Brown <len.brown@intel.com>

On Wed, Feb 20, 2019 at 5:55 AM David Arcari <darcari@redhat.com> wrote:
>
>
> ping -- just want to make sure this doesn't get lost.
>
> Thanks!
>
> On 02/12/2019 09:34 AM, David Arcari wrote:
> > turbostat failed to return a non-zero exit status even though the
> > supplied command (turbostat <command>) failed.  Currently when turbostat
> > forks a command it returns zero instead of the actual exit status of the
> > command.  Modify the code to return the exit status.
> >
> > Signed-off-by: David Arcari <darcari@redhat.com>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: Jirka Hladky <jhladky@redhat.com>
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  tools/power/x86/turbostat/turbostat.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> > index 9327c0d..c3fad06 100644
> > --- a/tools/power/x86/turbostat/turbostat.c
> > +++ b/tools/power/x86/turbostat/turbostat.c
> > @@ -5077,6 +5077,9 @@ int fork_it(char **argv)
> >               signal(SIGQUIT, SIG_IGN);
> >               if (waitpid(child_pid, &status, 0) == -1)
> >                       err(status, "waitpid");
> > +
> > +             if (WIFEXITED(status))
> > +                     status = WEXITSTATUS(status);
> >       }
> >       /*
> >        * n.b. fork_it() does not check for errors from for_all_cpus()
> >
>


-- 
Len Brown, Intel Open Source Technology Center
