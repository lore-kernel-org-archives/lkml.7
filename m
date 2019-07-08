Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB6FC606BF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3276421537
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732076AbfGHPEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:04:54 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43071 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730233AbfGHPEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:04:53 -0400
Received: by mail-pf1-f195.google.com with SMTP id i189so7745599pfg.10;
        Mon, 08 Jul 2019 08:04:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uuzMBczhpFd4zcYpjMdhnitg6M+5a5PUQK3Xnc+A9H8=;
        b=j8J6o81O8Kel0trZLKq/QJTiW8o9fOeSVRjcZ4jVDKP6IzQTQH348leOzEaTap+3PN
         I1mO0PAi8OCArSZWpzAjCoL09jKyK8q1BcjLRqwzuukGzNnFRnPF43JPKT3zg0dqvQ0b
         4HmPKNrRchQAQSr586Nc7tpzJumVLQKh+aQw77MKRJm65iGgXPx5psTwWhn6zVR3jvDT
         Y/IIfOU6aa8fjZgzu9EGVZmhv5jeCl93oZW7W7/FcNwwcp9wUA8ng+GLlEycbZiWx+gl
         dTwLaFU6jiUH8vDClP9oq4UVBVIhyawDk3xfxRl6CpIXcXpooiYCvrWHShlNzBoXPEzD
         iLtQ==
X-Gm-Message-State: APjAAAUcl5dj6iOFlAg4qczfv9fpfQJ7fR5OfpdG7LNtsLWwn5RShQiM
        K5XR1Rz2sWE+csJSo9Bfx7/F55pa
X-Google-Smtp-Source: APXvYqyJlMgwmQ5yvGTru8xbts6noQsMZxodcWdtoYVrpsTXXjLpzN1qyUzURq/d7YVTiwSh76fHqw==
X-Received: by 2002:a17:90a:208d:: with SMTP id f13mr25643200pjg.68.1562598292667;
        Mon, 08 Jul 2019 08:04:52 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id 1sm17843072pfe.102.2019.07.08.08.04.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 08:04:51 -0700 (PDT)
Subject: Re: [PATCH] scsi: Remove unreachable code
To:     Ding Xiang <dingxiang@cmss.chinamobile.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1562234156-11945-1-git-send-email-dingxiang@cmss.chinamobile.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <82794d9a-8f36-7012-da6a-1e05ce2bb3cb@acm.org>
Date:   Mon, 8 Jul 2019 08:04:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <1562234156-11945-1-git-send-email-dingxiang@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/4/19 2:55 AM, Ding Xiang wrote:
> The return code after switch default is unreachable,
> so remove it.
> 
> Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
> ---
>   drivers/scsi/scsi_error.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
> index bfa569f..12180f0 100644
> --- a/drivers/scsi/scsi_error.c
> +++ b/drivers/scsi/scsi_error.c
> @@ -1909,7 +1909,6 @@ int scsi_decide_disposition(struct scsi_cmnd *scmd)
>   	default:
>   		return FAILED;
>   	}
> -	return FAILED;

I'd rather remove the "default: return FAILED;" code than make the above 
change. If status_byte() ever would be changed into an inline function 
that returns an enum then my alternative will allow the compiler to 
verify whether all enum labels have been handled. No such check will be 
performed if the above patch would be applied.

Bart.
