Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E252C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 03:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75EC52075C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 03:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfHEDUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Aug 2019 23:20:30 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:55254 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726767AbfHEDUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 23:20:30 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TYeMSSC_1564975223;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TYeMSSC_1564975223)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 05 Aug 2019 11:20:23 +0800
Subject: Re: [PATCH 5/5] docs: zh_CN: howto.rst: fix a broken reference
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Harry Wei <harryxiyou@gmail.com>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        SeongJae Park <sj38.park@gmail.com>
References: <5c44856436bbaeb4f2d4b750365b82de973ad054.1564169297.git.mchehab+samsung@kernel.org>
 <36ee207d43dd40be23639a3b00de4216a8465624.1564169297.git.mchehab+samsung@kernel.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <2148e16c-335d-96ba-d132-bc4629dabc6a@linux.alibaba.com>
Date:   Mon, 5 Aug 2019 11:20:23 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <36ee207d43dd40be23639a3b00de4216a8465624.1564169297.git.mchehab+samsung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

Thanks for catching!
this part need more info, like make latexdocs. So I update them and sent out a patch for this. Please feel free to pick up my patch in your series. :)

Thanks!
Alex

在 2019/7/27 上午3:29, Mauro Carvalho Chehab 写道:
> There's a broken reference there pointing to the long gone
> DocBook dir.
> 
> While I don't read chinese, Google translator translates it
> to:
> 	"The generated documentation will be placed in
> 	 the Documentation/DocBook/ directory."
> 
> Well, we know that the output will be Documentation/output
> dir. So, let's fix this one.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  Documentation/translations/zh_CN/process/howto.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/translations/zh_CN/process/howto.rst b/Documentation/translations/zh_CN/process/howto.rst
> index 5b671178b17b..c4ff8356b88d 100644
> --- a/Documentation/translations/zh_CN/process/howto.rst
> +++ b/Documentation/translations/zh_CN/process/howto.rst
> @@ -147,7 +147,7 @@ Linux内核代码中包含有大量的文档。这些文档对于学习如何与
>      关于补丁是什么以及如何将它打在不同内核开发分支上的好介绍
>  
>  内核还拥有大量从代码自动生成的文档。它包含内核内部API的全面介绍以及如何
> -妥善处理加锁的规则。生成的文档会放在 Documentation/DocBook/目录下。在内
> +妥善处理加锁的规则。生成的文档会放在 Documentation/output/目录下。在内
>  核源码的主目录中使用以下不同命令将会分别生成PDF、Postscript、HTML和手册
>  页等不同格式的文档::
>  
> 
