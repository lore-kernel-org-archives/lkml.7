Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2473C47404
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 13:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC02521479
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 13:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732053AbfILNKY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 09:10:24 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34681 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731687AbfILNKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 09:10:24 -0400
Received: by mail-pf1-f196.google.com with SMTP id r12so16032320pfh.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 06:10:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o85hg2uRViTBTOdRLoeY1KBtWVrAtpQuUFP49tE28+E=;
        b=WSB5AUbdB4xAA60Le4BA4aGS0fvQM1l0+BujnAtPVUM9X7JRTG5KQXNqEFa4yTf4sT
         riYdYnSBPJ0Wp9EfsjiPkRCQNiLcFKIvh9xt43W0dlW7GWdpMDFPTDlBPDYuPSg8OCH0
         8ZnjLBw2ugIBE3Mi/awPY+KOfYN9Pl35nmSjTUI/y/+Yfytm6UXrXPD1J+mwkiAwQISL
         NJLyp9eNaqrY8ruVGI5XMc27exL27a2fu5T07gnvFaiWDrMtgC8dL4xa+QpgwHTrj8Q+
         3Lnr536Dxobbyj0JIMCFBZgYbn0dC3hHQopng3K2dh0toHqlmi3GEeaD5EhiSWZVMP3Q
         wZbA==
X-Gm-Message-State: APjAAAWq9ogIRtuR4Y6Jrg/MFRwELbqycPmREcs35a8LvdPFrmWPA1fi
        3JjeTjkk39dXs2BxerqZF5w=
X-Google-Smtp-Source: APXvYqzrRMGtNABoRFUEmvlswO8y/ZbF7TMze/iCEdYvrjifxzi3YYQpajJ4r+D8tdbIIPZ/7cqrJA==
X-Received: by 2002:a63:460c:: with SMTP id t12mr37672408pga.69.1568293823578;
        Thu, 12 Sep 2019 06:10:23 -0700 (PDT)
Received: from [172.19.249.100] ([38.98.37.138])
        by smtp.gmail.com with ESMTPSA id u65sm28133705pfu.104.2019.09.12.06.10.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2019 06:10:22 -0700 (PDT)
Subject: Re: [Ksummit-discuss] [PATCH v2 0/3] Maintainer Entry Profiles
To:     Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Dave Jiang <dave.jiang@intel.com>,
        ksummit-discuss@lists.linuxfoundation.org,
        linux-nvdimm@lists.01.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steve French <stfrench@microsoft.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Tobin C. Harding" <me@tobin.cc>
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <92fb4141-8e2d-1139-2f55-b7100be8a2fd@acm.org>
Date:   Thu, 12 Sep 2019 14:10:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/19 4:48 PM, Dan Williams wrote:
> At last years Plumbers Conference I proposed the Maintainer Entry
> Profile as a document that a maintainer can provide to set contributor
> expectations and provide fodder for a discussion between maintainers
> about the merits of different maintainer policies.
> 
> For those that did not attend, the goal of the Maintainer Entry Profile,
> and the Maintainer Handbook more generally, is to provide a desk
> reference for maintainers both new and experienced. The session
> introduction was:
> 
>     The first rule of kernel maintenance is that there are no hard and
>     fast rules. That state of affairs is both a blessing and a curse. It
>     has served the community well to be adaptable to the different
>     people and different problem spaces that inhabit the kernel
>     community. However, that variability also leads to inconsistent
>     experiences for contributors, little to no guidance for new
>     contributors, and unnecessary stress on current maintainers. There
>     are quite a few of people who have been around long enough to make
>     enough mistakes that they have gained some hard earned proficiency.
>     However if the kernel community expects to keep growing it needs to
>     be able both scale the maintainers it has and ramp new ones without
>     necessarily let them make a decades worth of mistakes to learn the
>     ropes. 
> 
> To be clear, the proposed document does not impose or suggest new
> rules. Instead it provides an outlet to document the unwritten rules
> and policies in effect for each subsystem, and that each subsystem
> might decide differently for whatever reason.

Any maintainer who reads this might interpret this as an encouragement
to establish custom policies. I think one of the conclusions of the
Linux Plumbers 2019 edition is that too much diversity is bad and that
we need more uniformity across kernel subsystems with regard what is
expected from patch contributors. I would appreciate if a summary of
https://linuxplumbersconf.org/event/4/contributions/554/attachments/353/584/Reflections__Kernel_Summit_2019.pdf
would be integrated in the maintainer handbook.

Thanks,

Bart.

