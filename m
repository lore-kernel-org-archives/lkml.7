Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7F0C10F0C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 08:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29B9E20643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 08:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ef02bbw0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfCKIcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 04:32:45 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35348 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfCKIco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 04:32:44 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2B8T5jV044177;
        Mon, 11 Mar 2019 08:32:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=3Lc7seH0lqZwB3Rlv1142wPh1zLr9fTlvx2nnOI3SNM=;
 b=Ef02bbw0v1X9/8h99v+gqnxrzX2hCZLee+mEJXbYrYRTzKLF1x2aFyR8OdePR4DJAvIg
 t0ULfU5+p7KN/5VXubFvYx5LxmDJ4jui1z69nhMY/kQGsOInqBv4fara4XF41B6yv9bi
 edzArMtpeg5WvVPsfXkx/atY3NYHfKsZkncsm6grI69VWbSToI/c6IPhnPe2yRLMBe9g
 kOxmygkCWDG+hA2mIvENt6ZL83TbSXir96RkEIcW3ks+7IS7sCdIT2wII//8ar3sBaO/
 6XAKmkIps6C4kndHaG4EOJYWUPDN+MMMYVzKjUgtkAY977lI0e2yZ5b2Yqrcvy9KiuUX 0Q== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2r464r4tr9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Mar 2019 08:32:13 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2B8WCbv012906
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Mar 2019 08:32:12 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2B8WBdg002890;
        Mon, 11 Mar 2019 08:32:11 GMT
Received: from kadam (/197.157.34.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 Mar 2019 01:32:10 -0700
Date:   Mon, 11 Mar 2019 11:31:59 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Karen Palacio <karen.palacio.1994@gmail.com>,
        devel@driverdev.osuosl.org, lars@metafoo.de,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, knaack.h@gmx.de,
        Mircea Caprioru <mircea.caprioru@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH] staging: iio: adc: ad7192: Add spaces around minus
 operator
Message-ID: <20190311083159.GE2434@kadam>
References: <1552252931-10592-1-git-send-email-karen.palacio.1994@gmail.com>
 <CA+U=Dso8UzRFcHj-2Ss08DmykuXaTzbYmtj3F40tzchgvb7zBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+U=Dso8UzRFcHj-2Ss08DmykuXaTzbYmtj3F40tzchgvb7zBw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9191 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903110065
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 10:12:48AM +0200, Alexandru Ardelean wrote:
> On Sun, Mar 10, 2019 at 11:23 PM Karen Palacio
> <karen.palacio.1994@gmail.com> wrote:
> >
> > Add spaces around minus operator to fix readibility.
> >
> > Signed-off-by: Karen Palacio <karen.palacio.1994@gmail.com>
> > ---
> >  drivers/staging/iio/adc/ad7192.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> > index acdbc07..7c632cf 100644
> > --- a/drivers/staging/iio/adc/ad7192.c
> > +++ b/drivers/staging/iio/adc/ad7192.c
> > @@ -355,7 +355,7 @@ ad7192_show_scale_available(struct device *dev,
> >  }
> >
> >  static IIO_DEVICE_ATTR_NAMED(in_v_m_v_scale_available,
> > -                            in_voltage-voltage_scale_available,
> > +                            in_voltage - voltage_scale_available,
> 
> This isn't broken, but I do agree it should be addressed.
> I think it's the second time I see a similar patch trying to fix this.
> So, obviously the code is a bit misleading.
> 

It's got to be more than that.  I did a simple grep of my inbox and it
says that this is the 13th time someone has tried to do this.  It's
possible that my grep is wrong, 13 seems high but not totaly impossible.

regards,
dan carpenter

