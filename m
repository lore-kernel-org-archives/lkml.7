Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B843C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 11:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3495C26865
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 11:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HLEW4BnA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbfEaLvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 07:51:21 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41522 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbfEaLvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 07:51:21 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4VBTRHF152543;
        Fri, 31 May 2019 11:51:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
 bh=kyN0JWNoL8zVHWWqDD9xEPLnKSbBKq8cFXp9yPsEgWE=;
 b=HLEW4BnALNGK/ytMN664KCn5PPnXsXQAOlaoTXdmbBIUS/lRrPPIZ8afwGOBB6ZRvaer
 SeB0UW2TxIeCfM+RyMQDW/+FUJMBHEZ4UAU9HeslDZLCcUsswr82GTeMoFqztUVzaYNO
 2AHIBR86AaESCL1LT//HHDYVZ2FbHjA9vViMGGUL7w4LUPgKqleaOisZ9D6WRoti4jzw
 dhAMwPU6+rPKgnQ2QWFnoYA8BKVKZN91OCXJv3UdoBl4mGgRubPXIQjGYwAo5m0CIsvq
 /I9GwtbF7qf9ppn09stVS1Vy6DT9tYm1e8ZSH+Fvs5bMQlcXdTeu1gNn7EPYzh2D9TAW mw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2spxbqnkqd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 May 2019 11:51:15 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4VBo6PL085582;
        Fri, 31 May 2019 11:51:15 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2sr31wcq21-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 May 2019 11:51:15 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4VBpDXj016871;
        Fri, 31 May 2019 11:51:14 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 31 May 2019 04:51:13 -0700
Date:   Fri, 31 May 2019 14:50:35 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Simon =?iso-8859-1?Q?Sandstr=F6m?= <simon@nikanor.nu>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: kpc2000: replace bogus variable name in core.c
Message-ID: <20190531115035.GE31203@kadam>
References: <20190529194222.9048-1-simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190529194222.9048-1-simon@nikanor.nu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9273 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=990
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905310076
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9273 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905310076
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 09:42:22PM +0200, Simon Sandström wrote:
> "struct kp2000_regs temp" has nothing to do with temperatures, so
> replace it with the more proper name "regs".
> 
> Signed-off-by: Simon Sandström <simon@nikanor.nu>
> ---

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

