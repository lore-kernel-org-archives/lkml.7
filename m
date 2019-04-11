Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D45C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 07:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE4B52184B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 07:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="38UGEhJ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfDKHW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 03:22:29 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59254 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfDKHW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 03:22:29 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3B7EL2l091664;
        Thu, 11 Apr 2019 07:22:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=gwXOzqYsTJdgXggtN8KTNGl+0QEJJchUS+eWs+lkNlU=;
 b=38UGEhJ8dKjNWUv4p5mmKMgDjgKqWZ1R8RqQm+5n95o/KOOfq2wPnhnjtzVor03wu0HN
 6TQpqkbujkiO+i8WNqnhKcHI9ToXw89vdgwoXA8hhY9IBVjgeDkwRZPkrumbTYPfmt89
 HnlzpvhJeTU6SuiiwZWfImXBhxUOUgsCviaNfv+WrZkn8x/iE/EBQWh8jG4A179LwScx
 qChKskoRKds1bnQgjFadEB2a9TYULU2XEEYQhtOmx8juyfCmVzO9NnzREKDmQ8CutCgj
 GT7cBcwjqcVqwUC14M/i+icCI73rsqnf2RKCiptqL8+StrO3CPPQD92Lk/+oBGkM+luR yw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2rpmrqf2x6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Apr 2019 07:22:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3B7LwdY134930;
        Thu, 11 Apr 2019 07:22:21 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2rpkeka375-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Apr 2019 07:22:21 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3B7MJuk024389;
        Thu, 11 Apr 2019 07:22:20 GMT
Received: from kadam (/41.202.241.15)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Apr 2019 00:22:19 -0700
Date:   Thu, 11 Apr 2019 10:22:08 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Madhumthia Prabakaran <madhumithabiw@gmail.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: rtl8723bs: Remove typedef in struct sdio_data
Message-ID: <20190411072208.GI6095@kadam>
References: <20190409161617.29871-1-madhumithabiw@gmail.com>
 <20190410064954.GE6095@kadam>
 <20190410194908.GA13242@madhuleo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410194908.GA13242@madhuleo>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9223 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904110051
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9223 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904110051
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 02:49:09PM -0500, Madhumthia Prabakaran wrote:
> On Wed, Apr 10, 2019 at 09:49:54AM +0300, Dan Carpenter wrote:
> > On Tue, Apr 09, 2019 at 11:16:17AM -0500, Madhumitha Prabakaran wrote:
> > > diff --git a/drivers/staging/rtl8723bs/include/drv_types.h b/drivers/staging/rtl8723bs/include/drv_types.h
> > > index bafb2c30e7fb..b0623c936940 100644
> > > --- a/drivers/staging/rtl8723bs/include/drv_types.h
> > > +++ b/drivers/staging/rtl8723bs/include/drv_types.h
> > > @@ -220,7 +220,7 @@ struct registry_priv
> > >  #define BSSID_SZ(field)   sizeof(((struct wlan_bssid_ex *) 0)->field)
> > >  
> > >  #include <drv_types_sdio.h>
> > > -#define INTF_DATA SDIO_DATA
> > > +#define INTF_DATA struct sdio_data
> > >  
> > 
> > Just get rid of INTF_DATA data as well.  It's only used once a bit lower
> > in the file.  (Get rid of the ifdef around it).
> 
> But, reference of INTF_DATA is also included in file 
> ./drivers/staging/rtl8723bs/include/drv_types.h:487:
> return &dvobj->intf_data.func->dev;
> 

Yes.  That's what I meant.  Get rid of that one and the ifdefs around
it.

regards,
dan carpenter

