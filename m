Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFB0C4CEC7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 20:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFD6F20830
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 20:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfILUBd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 16:01:33 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46785 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfILUBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 16:01:32 -0400
Received: by mail-pg1-f196.google.com with SMTP id m3so13991951pgv.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 13:01:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7ShxzRkwVpFXPFUhCMkn8w2H4SHeQQrrLJDUeQMUdcI=;
        b=FwgnYUX6lt+b5YXRMCE/8axuMwqiqnkgmzLg7wVCew1v04VAPsPmzu+fzWeHuvZvxu
         H14hfVMACdWKGlPrt9jdGWlSOtc1vwlXQKqQ5uO26ofzSvtofo7XhpUC69YJmtmEl5ml
         DPv4DZ9kIFndnA9Rb3NG41rm7cHJ4Zu72fmn1HvHZAAfIQWdQ//PhlWj4eekH+esdDfR
         J67nFOKWMkO1jbtSi3vmZDMkKlUpT4a6hZB2VWXk+3R5jrOWTgLS2wp2ixfGksn+AZFi
         oc6q65CW4kwTU9bevgQmmxkg6iUl2cio8aovloK8mcwtBbQPaPosyOUy9zTlmpcjmiJJ
         qSTQ==
X-Gm-Message-State: APjAAAXcWu8avqwstw7ZTe92LzVuz7APo2XrFw/+d4qlBPgWtU+j0UVo
        oxZOATFKBo2c5dzNrlDVqkY=
X-Google-Smtp-Source: APXvYqyry5egiR7l6s0aQO4rPH0UT6pfvHSg90vmXu4bIiK4MHA+WwyQh+uKxb6FVD5SJXGN+IyDag==
X-Received: by 2002:a63:fe52:: with SMTP id x18mr23647280pgj.344.1568318491686;
        Thu, 12 Sep 2019 13:01:31 -0700 (PDT)
Received: from [192.168.43.134] ([38.98.37.138])
        by smtp.gmail.com with ESMTPSA id v43sm134470pjb.1.2019.09.12.13.01.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2019 13:01:30 -0700 (PDT)
Subject: Re: [Ksummit-discuss] [PATCH v2 0/3] Maintainer Entry Profiles
To:     Joe Perches <joe@perches.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Jiang <dave.jiang@intel.com>,
        ksummit-discuss@lists.linuxfoundation.org,
        linux-nvdimm@lists.01.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Steve French <stfrench@microsoft.com>,
        "Tobin C. Harding" <me@tobin.cc>
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
 <yq1o8zqeqhb.fsf@oracle.com> <6fe45562-9493-25cf-afdb-6c0e702a49b4@acm.org>
 <44c08faf43fa77fb271f8dbb579079fb09007716.camel@perches.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <74984dc0-d5e4-f272-34b9-9a78619d5a83@acm.org>
Date:   Thu, 12 Sep 2019 13:01:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <44c08faf43fa77fb271f8dbb579079fb09007716.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/19 8:34 AM, Joe Perches wrote:
> On Thu, 2019-09-12 at 14:31 +0100, Bart Van Assche wrote:
>> On 9/11/19 5:40 PM, Martin K. Petersen wrote:
>>> * The patch must compile without warnings (make C=1 CF="-D__CHECK_ENDIAN__")
>>>   and does not incur any zeroday test robot complaints.
>>
>> How about adding W=1 to that make command?
> 
> That's rather too compiler version dependent and new
> warnings frequently get introduced by new compiler versions.

I've never observed this myself. If a new compiler warning is added to
gcc and if it produces warnings that are not useful for kernel code
usually Linus or someone else is quick to suppress that warning.

Another argument in favor of W=1 is that the formatting of kernel-doc
headers is checked only if W=1 is passed to make.

Bart.

