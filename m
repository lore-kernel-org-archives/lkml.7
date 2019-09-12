Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C88C4CEC8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 13:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A68420830
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 13:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732207AbfILNb5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 09:31:57 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43352 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731840AbfILNb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 09:31:57 -0400
Received: by mail-pl1-f196.google.com with SMTP id 4so11801116pld.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 06:31:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YbzzOwLPVFiyZazgwx4oK1haet1LCDg9IL0AWwLCITc=;
        b=k/9YeQSKMsc/wkWdnArmH3DHeD9JnAkXMK4f6azI6K1jxF4Mhq3zoXh3rZ6wKw8n+Z
         5xampD7xM7okZPPpO+zYgYAbTxNkWgrHyhq/ozVJ82jzvMmzhUkKc3/qiKdOFLNfUTpw
         YNjmQpwjIU9VRgurhvQh+K3xecPqOWHr+CjS3msopDa85JlXHnUoBH1gadkgDc21bCR6
         PJ112C12UGA+NyEDy1wjQNBxcbxX5oY45MBzSEyo9+UUpgHXxW5IVQGGcHX/Xju4x2ZH
         gQh40M67rd1s39DSVnzXScLq0ff5EsgMx8S/o0Swgbs7K/IF8ip6X6PntsdWmSI3d/3a
         /F4w==
X-Gm-Message-State: APjAAAW1ISASX+T+IbUMDbnBmyl5diHNwYYLGDorpTU5ejtYlrydinLR
        bYDtM9H/7on2IRbNvkMB6wE=
X-Google-Smtp-Source: APXvYqyA9LmsIt46UYXRB/qnJg8y7VckXgkY1MT7b0npn/YciW4Pp1oR+XE+tg5ecGsQCpqqGjw73Q==
X-Received: by 2002:a17:902:b710:: with SMTP id d16mr12261985pls.55.1568295115090;
        Thu, 12 Sep 2019 06:31:55 -0700 (PDT)
Received: from [172.19.249.100] ([38.98.37.138])
        by smtp.gmail.com with ESMTPSA id c125sm31524292pfa.107.2019.09.12.06.31.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2019 06:31:54 -0700 (PDT)
Subject: Re: [Ksummit-discuss] [PATCH v2 0/3] Maintainer Entry Profiles
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Jiang <dave.jiang@intel.com>,
        ksummit-discuss@lists.linuxfoundation.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steve French <stfrench@microsoft.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Tobin C. Harding" <me@tobin.cc>
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
 <yq1o8zqeqhb.fsf@oracle.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <6fe45562-9493-25cf-afdb-6c0e702a49b4@acm.org>
Date:   Thu, 12 Sep 2019 14:31:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <yq1o8zqeqhb.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/19 5:40 PM, Martin K. Petersen wrote:
> * Do not use custom To: and Cc: for individual patches. We want to see the
>   whole series, even patches that potentially need to go through a different
>   subsystem tree.

Hi Martin,

Thanks for having written this summary. This is very helpful. For the
above paragraph, should it be clarified whether that requirement applies
to mailing list e-mail addresses only or also to individual e-mail
addresses? When using git send-email it is easy to end up with different
cc-lists per patch.

> * The patch must compile without warnings (make C=1 CF="-D__CHECK_ENDIAN__")
>   and does not incur any zeroday test robot complaints.

How about adding W=1 to that make command?

How about existing drivers that trigger tons of endianness warnings,
e.g. qla2xxx? How about requiring that no new warnings are introduced?

> * The patch must have a commit message that describes, comprehensively and in
>   plain English, what the patch does.

How about making this requirement more detailed and requiring that not
only what has been changed is document but also why that change has been
made?

> * Patches which have been obsoleted by a later version will be set to
>   "Superceded" status.

Did you perhaps mean "Superseded"?

Thanks,

Bart.

