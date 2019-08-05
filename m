Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3209EC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 016972067D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJq/Jtyg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbfHENjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:39:23 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40267 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfHENjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:39:22 -0400
Received: by mail-io1-f66.google.com with SMTP id h6so42136471iom.7;
        Mon, 05 Aug 2019 06:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=FLq+GsK2RBOu2svVdDO4l5xiwRawI+I647gJYjWfm7E=;
        b=KJq/JtygoaDwC4qXHEUx4uHJ4LiIZ4He9ZLfwnVLvyQCmvt3bZA3SRsfLRftxqtvFr
         Yaw3JR4KkjPN5XmhhxeBc1CRfruClo0iotX9pEvMv5BpMDAVTE32u4d4kOf2gB1i1d9Y
         zlNITSPcQ1klGLtWtThpr52wA4Sr5aqp3dbSIu+jCjEhQyajVLLuc+BdKgCGIT6SOaZf
         XupKZypE1HcJjOKbTvUsokOy2LX62Ge2DrSzF7DA3ttmlqvwmIYeMk9If9jQyvCmEPle
         4Ytk9zrn7CA9KzJBY6lM+6e2lPKOQuG63MZqU2MiD5VORTnNaC4tQ2vxE87jOv0Qbjwm
         Xyrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=FLq+GsK2RBOu2svVdDO4l5xiwRawI+I647gJYjWfm7E=;
        b=VaVzB0xj64872TAKVUGcSsJArwOygf87LnQcT4r1K1yD8PYlqHZViYWrdEEZoMwVIi
         6YleXIS6C0YrCShI8zV5Sr54FvHbvMCvLZTN5p16D3Ev04aVN+wDb5eCzm7lVPYV7yl5
         Szy5RnErnmoPXnKFx6c6NoG89aIwNE7luuoXzRO9W5shIByrDVXRixFJ+KcpbciDeogm
         pgY3c1nz7TACZn/vJjq2g3qSCfvpKXxhYaiqlnf9dyr9k2rbt4uv2FB1Hge6i63Tf17h
         yl2kaUgiO5Kxc/Zp12+lFcwtblVX8Sqh3S4NO0Tc0LX07CCpd65m8nulKQnMyY/RRxY4
         CXyQ==
X-Gm-Message-State: APjAAAXb/bfk20/V/cHublf3UeB7E+3rSxEblZdkmWfadG1alm3qBh94
        RAGrTZC+6mWpY8ZPSBDezC6QT3gVNL0akvd4itl3CwWLCg0=
X-Google-Smtp-Source: APXvYqwUB0JliaEvraelaWIKOhLmG6tm/hH6p5K7VUkG0ux1iC8pWz5nAVPBujCAZpeSSCdA02a33d85QL7ElUmyspg=
X-Received: by 2002:a5d:8e16:: with SMTP id e22mr13411396iod.171.1565012361842;
 Mon, 05 Aug 2019 06:39:21 -0700 (PDT)
MIME-Version: 1.0
From:   Jaafar Ali <jaafarkhalaf@gmail.com>
Date:   Mon, 5 Aug 2019 16:34:19 +0300
Message-ID: <CAF-0O_6zDyWTFenFX49DVeSyB=p59BFVCc71oPVarOtDPh2LFg@mail.gmail.com>
Subject: Odroid-XU$ sound issue after suspend-resume
To:     linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,
Kernel 5.3-rc1
OS: ubuntu 18.04
Hardware: Odroid-XU4
The sound of Odroid-XU4 after suspend/resume cycle is choppy and slow.
I have found a workaround, the I2SMOD register value should be set to
zero after resume to force using internal codec clock (cdclkcon bit =
0),  also the rclk_srcrate which is obtained from the function
clk_get_rate(rclksrc) inside hw_params function is not correct and
must be divided by 2 to obtain proper value, i2s_resume function is
modified to:

static int i2s_resume(struct snd_soc_dai *dai)
{
        struct samsung_i2s_priv *priv = dev_get_drvdata(dai->dev);
        priv->suspend_i2smod = 0;//workaround-1 ,
        return pm_runtime_force_resume(dai->dev);

}

 inside hw_params function, the rclk_srcrate must be halved to solve
unknown problem of clock shift, so before return from hw_params we
must insert:
if(mod == 0){
priv->rclk_srcrate = priv->rclk_srcrate / 2; //workaround-2,
}
return 0;

With these two workaround sound issue was solved, but I hope we can
get concrete fix.

Best Regards


Jaafar
