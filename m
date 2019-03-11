Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E928AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 12:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C13FF20657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 12:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfCKMfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 08:35:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:35360 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726826AbfCKMfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 08:35:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0F58DAF93;
        Mon, 11 Mar 2019 12:35:42 +0000 (UTC)
Subject: Re: [PATCH v2] AMD perf PMU events for AMD Family 17h.
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     William Cohen <wcohen@redhat.com>,
        linux-perf-users@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Martin Jambor <mjambor@suse.cz>, Jiri Olsa <jolsa@redhat.com>,
        Borislav Petkov <bpetkov@suse.de>
References: <3ee15066-429e-b0f2-1255-aab100fad472@suse.cz>
 <fc049074-595e-92d7-5bab-bcd00f8493e2@suse.cz>
 <20180823143141.GA22309@kernel.org>
 <40464a66-9085-f26c-88cd-8d510b07a859@redhat.com>
 <d65873ca-e402-b198-4fe9-8c4af81258c8@suse.cz>
 <32d6a969-8b15-cda1-1057-9923733dbe39@suse.cz>
 <20190308165747.GA10690@kernel.org>
From:   =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
Message-ID: <3cdd0ff4-b189-6869-e30b-d616b4d7ae48@suse.cz>
Date:   Mon, 11 Mar 2019 13:35:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <20190308165747.GA10690@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/19 5:57 PM, Arnaldo Carvalho de Melo wrote:
> Collected Boris's Acked-by and the original cset commit log and the
> patch at the end of the message, next time please resubmit with a:
> 
>   [PATCH v2] proper summary
> 
>   proper description
> 
>   collect acks
>   s-o-b
> 
> Thanks,
> 
> - Arnaldo

Thank you Arnaldo.

I'll make better next time ;)

Martin
