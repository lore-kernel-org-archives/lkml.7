Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB52C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A641D217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EUG+o/lQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbfCNL17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 07:27:59 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43808 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfCNL16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 07:27:58 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2EBJK3S172818;
        Thu, 14 Mar 2019 11:27:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=Le8UAUdoSGnHWNDAHe9ATwLbJm9Dei1A3Ha7QuxbK94=;
 b=EUG+o/lQBPxq2OgkE5hvBu1uk97FwAs+0KYHBL7HjXcPd1TC2TSB9hhjJq4EXxQMgCoW
 EuLhdtOby/RXQkd1/yuPbrBp7w56SZ5hRKzffw04mbZm0rIZNIbYQs0gtNffQWlDCJsq
 apbCgZjWrUJX0fyU4aubHi7ywJZESrfAuG6elFzL3UFqp+wQ5JRfZb4XwWn7R+KWniaT
 ghTPej2oVPTR7FVxojyouTrn8U4vGqHH+qnjrctGO00HzEYC2oMzQHdrZ6r1iGT4aSIL
 083n+IOy71rAj9voJiybURxPCXu3ADEwch3hJU3z3vmgeqUZUf229JOh4W1Q3KcXiUva uA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2r44wugcex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Mar 2019 11:27:44 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2EBRh2J007277
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Mar 2019 11:27:43 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2EBRgfJ021577;
        Thu, 14 Mar 2019 11:27:42 GMT
Received: from kadam (/197.157.0.16)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Mar 2019 11:27:41 +0000
Date:   Thu, 14 Mar 2019 14:27:32 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Armando Miraglia <arma2ff0@gmail.com>,
        Jean Delvare <jdelvare@suse.de>
Cc:     neil@brown.name, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, sankalpnegi2310@gmail.com,
        matthias.bgg@gmail.com, sr@denx.de,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] spi: mediatek: Attempt to address style issues in
 spi-mt7621.c
Message-ID: <20190314112732.GJ2227@kadam>
References: <20190313122403.248873-1-armax@google.com>
 <20190313123454.GB2202@kadam>
 <20190314111313.GB8034@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190314111313.GB8034@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9194 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903140081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 12:13:15PM +0100, Armando Miraglia wrote:
> My answers are in-line below. BTW bare with me as this is my attempt to get my
> feet wet in how to contribute to the linux kernel for my own pleasure and
> interest :)
> 

No problem at all.

> Is there an explicit intent to deprecate Lindent in favor of checkpatch.pl
> --fix? If one would like to contribute to fixing the tooling for linting which
> of the two would be the right target for such an effort?
> 

I've added Jean to the CC list because he worked on Lindent a few
years ago.  I really think we should just delete Lindent.  I haven't
used the checkpatch.pl --fix option but Joe Perches has good style.

> > >  static inline struct mt7621_spi *spidev_to_mt7621_spi(struct spi_device *spi)
> > > @@ -303,7 +303,7 @@ static int mt7621_spi_setup(struct spi_device *spi)
> > >  	struct mt7621_spi *rs = spidev_to_mt7621_spi(spi);
> > >  
> > >  	if ((spi->max_speed_hz == 0) ||
> > > -		(spi->max_speed_hz > (rs->sys_freq / 2)))
> > > +	    (spi->max_speed_hz > (rs->sys_freq / 2)))
> > 
> > Yeah.  Lindent is correct here.
> 
> Funny enough, this is something I adjusted manually :)
> 

:)  Good.

> I have a process question here: to post a change for the only accepted change I
> have in this patch should I send out a new patch?
> 

Yeah.  If you want.  Google for how to send a v2 patch.

regards,
dan carpenter
