Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C576C4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 10:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 492E8216E3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 10:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbfGEKy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 06:54:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47822 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728087AbfGEKy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 06:54:26 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x65ArTq0031748
        for <linux-kernel@vger.kernel.org>; Fri, 5 Jul 2019 06:54:21 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tj25ux8mh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 06:54:15 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Fri, 5 Jul 2019 11:54:12 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 5 Jul 2019 11:54:08 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x65As6WJ37159398
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 5 Jul 2019 10:54:06 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 756994C050;
        Fri,  5 Jul 2019 10:54:06 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 217BC4C04A;
        Fri,  5 Jul 2019 10:54:06 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.152.224.145])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  5 Jul 2019 10:54:06 +0000 (GMT)
Subject: Re: [PATCH 2/3] docs: s390: unify and update s390dbf kdocs at debug.c
To:     Steffen Maier <maier@linux.ibm.com>, linux-doc@vger.kernel.org
Cc:     linux-s390@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-kernel@vger.kernel.org
References: <1562149189-1417-1-git-send-email-maier@linux.ibm.com>
 <1562149189-1417-3-git-send-email-maier@linux.ibm.com>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=borntraeger@de.ibm.com; prefer-encrypt=mutual; keydata=
 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
 syiRa+UVlsKmx1hsEg==
Date:   Fri, 5 Jul 2019 12:54:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1562149189-1417-3-git-send-email-maier@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19070510-4275-0000-0000-0000034960FF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070510-4276-0000-0000-0000385982F5
Message-Id: <00fc9b6e-1faa-9409-f703-e4888ca54a16@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-05_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907050136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03.07.19 12:19, Steffen Maier wrote:
> For non-static-inlines, debug.c already had non-compliant function
> header docs. So move the pure prototype kdocs of
> ("s390: include/asm/debug.h add kerneldoc markups")
> from debug.h to debug.c and merge them with the old function docs.
> Also, I had the impression that kdoc typically is at the implementation
> in the compile unit rather than at the prototype in the header file.
> 
> While at it, update the short kdoc description to distinguish the
> different functions. And a few more consistency cleanups.
> 
> Added a new kdoc for debug_set_critical() since debug.h comments it
> as part of the API.
> 
> Signed-off-by: Steffen Maier <maier@linux.ibm.com>

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

> ---
>  Documentation/s390/s390dbf.rst |   1 +
>  arch/s390/include/asm/debug.h  | 112 ++++++-----------------------------------
>  arch/s390/kernel/debug.c       | 105 +++++++++++++++++++++++++++++++-------
>  3 files changed, 102 insertions(+), 116 deletions(-)
> 
> diff --git a/Documentation/s390/s390dbf.rst b/Documentation/s390/s390dbf.rst
> index 01d66251643d..be42892b159e 100644
> --- a/Documentation/s390/s390dbf.rst
> +++ b/Documentation/s390/s390dbf.rst
> @@ -107,6 +107,7 @@ will stay deactivated.
>  Kernel Interfaces:
>  ------------------
>  
> +.. kernel-doc:: arch/s390/kernel/debug.c
>  .. kernel-doc:: arch/s390/include/asm/debug.h
>  
>  Predefined views:
> diff --git a/arch/s390/include/asm/debug.h b/arch/s390/include/asm/debug.h
> index 02c36eedd780..310134015541 100644
> --- a/arch/s390/include/asm/debug.h
> +++ b/arch/s390/include/asm/debug.h
> @@ -95,77 +95,19 @@ debug_entry_t *debug_exception_common(debug_info_t *id, int level,
>  
>  /* Debug Feature API: */
>  
> -/**
> - * debug_register() - allocates memory for a debug log.
> - *
> - * @name:        Name of debug log (e.g. used for debugfs entry)
> - * @pages:       Number of pages, which will be allocated per area
> - * @nr_areas:    Number of debug areas
> - * @buf_size:    Size of data area in each debug entry
> - *
> - * Return:
> - * - Handler for generated debug area
> - * - %NULL if register failed
> - *
> - * Must not be called within an interrupt handler.
> - */
>  debug_info_t *debug_register(const char *name, int pages, int nr_areas,
>  			     int buf_size);
>  
> -/**
> - * debug_register_mode() - allocates memory for a debug log.
> - *
> - * @name:	Name of debug log (e.g. used for debugfs entry)
> - * @pages:	Number of pages, which will be allocated per area
> - * @nr_areas:	Number of debug areas
> - * @buf_size:	Size of data area in each debug entry
> - * @mode:	File mode for debugfs files. E.g. S_IRWXUGO
> - * @uid:	User ID for debugfs files. Currently only 0 is supported.
> - * @gid:	Group ID for debugfs files. Currently only 0 is supported.
> - *
> - * Return:
> - * - Handler for generated debug area
> - * - %NULL if register failed
> - *
> - * Must not be called within an interrupt handler
> - */
>  debug_info_t *debug_register_mode(const char *name, int pages, int nr_areas,
>  				  int buf_size, umode_t mode, uid_t uid,
>  				  gid_t gid);
>  
> -/**
> - * debug_unregister() - frees memory for a debug log and removes all
> - *			registered debug
> - * views.
> - *
> - * @id:		handle for debug log
> - *
> - * Return:
> - *    none
> - *
> - * Must not be called within an interrupt handler
> - */
>  void debug_unregister(debug_info_t *id);
>  
> -/**
> - * debug_set_level() -  Sets new actual debug level if new_level is valid.
> - *
> - * @id:		handle for debug log
> - * @new_level:	new debug level
> - *
> - * Return:
> - *    none
> - */
>  void debug_set_level(debug_info_t *id, int new_level);
>  
>  void debug_set_critical(void);
>  
> -/**
> - * debug_stop_all() - stops the debug feature if stopping is allowed.
> - *
> - * Return:
> - * -   none
> - */
>  void debug_stop_all(void);
>  
>  /**
> @@ -184,7 +126,7 @@ static inline bool debug_level_enabled(debug_info_t *id, int level)
>  }
>  
>  /**
> - * debug_event() - writes debug entry to active debug area
> + * debug_event() - writes binary debug entry to active debug area
>   *		   (if level <= actual debug level)
>   *
>   * @id:		handle for debug log
> @@ -194,6 +136,7 @@ static inline bool debug_level_enabled(debug_info_t *id, int level)
>   *
>   * Return:
>   * - Address of written debug entry
> + * - %NULL if error
>   */
>  static inline debug_entry_t *debug_event(debug_info_t *id, int level,
>  					 void *data, int length)
> @@ -204,7 +147,7 @@ static inline debug_entry_t *debug_event(debug_info_t *id, int level,
>  }
>  
>  /**
> - * debug_int_event() - writes debug entry to active debug area
> + * debug_int_event() - writes unsigned integer debug entry to active debug area
>   *		       (if level <= actual debug level)
>   *
>   * @id:		handle for debug log
> @@ -226,12 +169,12 @@ static inline debug_entry_t *debug_int_event(debug_info_t *id, int level,
>  }
>  
>  /**
> - * debug_long_event() - writes debug entry to active debug area
> + * debug_long_event() - writes unsigned long debug entry to active debug area
>   *		       (if level <= actual debug level)
>   *
>   * @id:		handle for debug log
>   * @level:	debug level
> - * @tag:	integer value for debug entry
> + * @tag:	long integer value for debug entry
>   *
>   * Return:
>   * - Address of written debug entry
> @@ -248,7 +191,7 @@ static inline debug_entry_t *debug_long_event(debug_info_t *id, int level,
>  }
>  
>  /**
> - * debug_text_event() - writes debug entry in ascii format to active
> + * debug_text_event() - writes string debug entry in ascii format to active
>   *			debug area (if level <= actual debug level)
>   *
>   * @id:		handle for debug log
> @@ -306,9 +249,9 @@ static inline debug_entry_t *debug_text_event(debug_info_t *id, int level,
>  })
>  
>  /**
> - * debug_exception() - writes debug entry to active debug area
> - *		       (if level <= actual debug level) and switches
> - *		       to next debug area
> + * debug_exception() - writes binary debug entry to active debug area
> + *		       (if level <= actual debug level)
> + *		       and switches to next debug area
>   *
>   * @id:		handle for debug log
>   * @level:	debug level
> @@ -328,7 +271,7 @@ static inline debug_entry_t *debug_exception(debug_info_t *id, int level,
>  }
>  
>  /**
> - * debug_int_exception() - writes debug entry to active debug area
> + * debug_int_exception() - writes unsigned int debug entry to active debug area
>   *			   (if level <= actual debug level)
>   *			   and switches to next debug area
>   *
> @@ -351,13 +294,13 @@ static inline debug_entry_t *debug_int_exception(debug_info_t *id, int level,
>  }
>  
>  /**
> - * debug_long_exception() - writes debug entry to active debug area
> + * debug_long_exception() - writes long debug entry to active debug area
>   *			   (if level <= actual debug level)
>   *			   and switches to next debug area
>   *
>   * @id:		handle for debug log
>   * @level:	debug level
> - * @tag:	integer value for debug entry
> + * @tag:	long integer value for debug entry
>   *
>   * Return:
>   * - Address of written debug entry
> @@ -374,9 +317,9 @@ static inline debug_entry_t *debug_long_exception (debug_info_t *id, int level,
>  }
>  
>  /**
> - * debug_text_exception() - writes debug entry in ascii format to active
> + * debug_text_exception() - writes string debug entry in ascii format to active
>   *			    debug area (if level <= actual debug level)
> - *			    and switches to next debug
> + *			    and switches to next debug area
>   * area
>   *
>   * @id:	handle for debug log
> @@ -407,7 +350,7 @@ static inline debug_entry_t *debug_text_exception(debug_info_t *id, int level,
>  /**
>   * debug_sprintf_exception() - writes debug entry with format string and
>   *			       varargs (longs) to active debug area
> - *			       (if level $<=$ actual debug level)
> + *			       (if level <= actual debug level)
>   *			       and switches to next debug area.
>   *
>   * @_id:	handle for debug log
> @@ -435,33 +378,8 @@ static inline debug_entry_t *debug_text_exception(debug_info_t *id, int level,
>  	__ret;								\
>  })
>  
> -/**
> - * debug_register_view() - registers new debug view and creates debugfs
> - *			   dir entry
> - *
> - * @id:	handle for debug log
> - * @view:	pointer to debug view struct
> - *
> - * Return:
> - * -   0  : ok
> - * -   < 0: Error
> - */
>  int debug_register_view(debug_info_t *id, struct debug_view *view);
>  
> -/**
> - * debug_unregister_view()
> - *
> - * @id:	handle for debug log
> - * @view:	pointer to debug view struct
> - *
> - * Return:
> - * -   0  : ok
> - * -   < 0: Error
> - *
> - *
> - * unregisters debug view and removes debugfs dir entry
> - */
> -
>  int debug_unregister_view(debug_info_t *id, struct debug_view *view);
>  
>  /*
> diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
> index 0ebf08c3b35e..70a44bad625f 100644
> --- a/arch/s390/kernel/debug.c
> +++ b/arch/s390/kernel/debug.c
> @@ -647,11 +647,23 @@ static int debug_close(struct inode *inode, struct file *file)
>  	return 0; /* success */
>  }
>  
> -/*
> - * debug_register_mode:
> - * - Creates and initializes debug area for the caller
> - *   The mode parameter allows to specify access rights for the s390dbf files
> - * - Returns handle for debug area
> +/**
> + * debug_register_mode() - creates and initializes debug area.
> + *
> + * @name:	Name of debug log (e.g. used for debugfs entry)
> + * @pages_per_area:	Number of pages, which will be allocated per area
> + * @nr_areas:	Number of debug areas
> + * @buf_size:	Size of data area in each debug entry
> + * @mode:	File mode for debugfs files. E.g. S_IRWXUGO
> + * @uid:	User ID for debugfs files. Currently only 0 is supported.
> + * @gid:	Group ID for debugfs files. Currently only 0 is supported.
> + *
> + * Return:
> + * - Handle for generated debug area
> + * - %NULL if register failed
> + *
> + * Allocates memory for a debug log.
> + * Must not be called within an interrupt handler.
>   */
>  debug_info_t *debug_register_mode(const char *name, int pages_per_area,
>  				  int nr_areas, int buf_size, umode_t mode,
> @@ -681,10 +693,21 @@ debug_info_t *debug_register_mode(const char *name, int pages_per_area,
>  }
>  EXPORT_SYMBOL(debug_register_mode);
>  
> -/*
> - * debug_register:
> - * - creates and initializes debug area for the caller
> - * - returns handle for debug area
> +/**
> + * debug_register() - creates and initializes debug area with default file mode.
> + *
> + * @name:	Name of debug log (e.g. used for debugfs entry)
> + * @pages_per_area:	Number of pages, which will be allocated per area
> + * @nr_areas:	Number of debug areas
> + * @buf_size:	Size of data area in each debug entry
> + *
> + * Return:
> + * - Handle for generated debug area
> + * - %NULL if register failed
> + *
> + * Allocates memory for a debug log.
> + * The debugfs file mode access permisions are read and write for user.
> + * Must not be called within an interrupt handler.
>   */
>  debug_info_t *debug_register(const char *name, int pages_per_area,
>  			     int nr_areas, int buf_size)
> @@ -694,9 +717,13 @@ debug_info_t *debug_register(const char *name, int pages_per_area,
>  }
>  EXPORT_SYMBOL(debug_register);
>  
> -/*
> - * debug_unregister:
> - * - give back debug area
> +/**
> + * debug_unregister() -  give back debug area.
> + *
> + * @id:		handle for debug log
> + *
> + * Return:
> + *    none
>   */
>  void debug_unregister(debug_info_t *id)
>  {
> @@ -745,9 +772,14 @@ static int debug_set_size(debug_info_t *id, int nr_areas, int pages_per_area)
>  	return rc;
>  }
>  
> -/*
> - * debug_set_level:
> - * - set actual debug level
> +/**
> + * debug_set_level() -  Sets new actual debug level if new_level is valid.
> + *
> + * @id:		handle for debug log
> + * @new_level:	new debug level
> + *
> + * Return:
> + *    none
>   */
>  void debug_set_level(debug_info_t *id, int new_level)
>  {
> @@ -873,6 +905,14 @@ static int s390dbf_procactive(struct ctl_table *table, int write,
>  
>  static struct ctl_table_header *s390dbf_sysctl_header;
>  
> +/**
> + * debug_stop_all() - stops the debug feature if stopping is allowed.
> + *
> + * Return:
> + * -   none
> + *
> + * Currently used in case of a kernel oops.
> + */
>  void debug_stop_all(void)
>  {
>  	if (debug_stoppable)
> @@ -880,6 +920,17 @@ void debug_stop_all(void)
>  }
>  EXPORT_SYMBOL(debug_stop_all);
>  
> +/**
> + * debug_set_critical() - event/exception functions try lock instead of spin.
> + *
> + * Return:
> + * -   none
> + *
> + * Currently used in case of stopping all CPUs but the current one.
> + * Once in this state, functions to write a debug entry for an
> + * event or exception no longer spin on the debug area lock,
> + * but only try to get it and fail if they do not get the lock.
> + */
>  void debug_set_critical(void)
>  {
>  	debug_critical = 1;
> @@ -1036,8 +1087,16 @@ debug_entry_t *__debug_sprintf_exception(debug_info_t *id, int level, char *stri
>  }
>  EXPORT_SYMBOL(__debug_sprintf_exception);
>  
> -/*
> - * debug_register_view:
> +/**
> + * debug_register_view() - registers new debug view and creates debugfs
> + *			   dir entry
> + *
> + * @id:		handle for debug log
> + * @view:	pointer to debug view struct
> + *
> + * Return:
> + * -   0  : ok
> + * -   < 0: Error
>   */
>  int debug_register_view(debug_info_t *id, struct debug_view *view)
>  {
> @@ -1077,8 +1136,16 @@ int debug_register_view(debug_info_t *id, struct debug_view *view)
>  }
>  EXPORT_SYMBOL(debug_register_view);
>  
> -/*
> - * debug_unregister_view:
> +/**
> + * debug_unregister_view() - unregisters debug view and removes debugfs
> + *			     dir entry
> + *
> + * @id:		handle for debug log
> + * @view:	pointer to debug view struct
> + *
> + * Return:
> + * -   0  : ok
> + * -   < 0: Error
>   */
>  int debug_unregister_view(debug_info_t *id, struct debug_view *view)
>  {
> 

